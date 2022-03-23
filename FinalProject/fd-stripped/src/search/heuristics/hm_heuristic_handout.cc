#include "hm_heuristic_handout.h"

#include "../globals.h"
#include "../operator.h"
#include "../option_parser.h"
#include "../plugin.h"
#include "../state.h"

#include <cassert>
#include <limits>
#include <set>

using namespace std;


HMHeuristic::HMHeuristic(const Options &opts)
    : Heuristic(opts),
      m(opts.get<int>("m")) {
}


HMHeuristic::~HMHeuristic() {
}


bool HMHeuristic::dead_ends_are_reliable() const {
    return !has_axioms() && !has_conditional_effects();
}


void HMHeuristic::initialize() {
    cout << "Using h^" << m << "." << endl;
    cout << "The implementation of the h^m heuristic is preliminary." << endl
         << "It is SLOOOOOOOOOOOW." << endl
         << "Please do not use this for comparison!" << endl;
    generate_all_tuples();
}


int HMHeuristic::compute_heuristic(const State &state) {
    // If we are in a goal state. Return 0 
    if (test_goal(state)) {
        return 0;
    } else {
        Tuple s_tup;
        state_to_tuple(state, s_tup);

        // Build a new hm table
        init_hm_table(s_tup);
        update_hm_table();
        //dump_table();

        int h = eval(g_goal);
    
        if (h == numeric_limits<int>::max())
            return DEAD_END;
        return h;
    }
}


void HMHeuristic::init_hm_table(Tuple &t) {
    map<Tuple, int>::iterator it;
    for (it = hm_table.begin(); it != hm_table.end(); ++it) {
        pair<Tuple, int> hm_ent = *it;
        Tuple &tup = hm_ent.first;
	    //Initialize h_val per column to either 0 or infinite
        int h_val = check_tuple_in_tuple(tup, t);
        hm_table[tup] = h_val;
    }
}


void HMHeuristic::update_hm_table() {
    // set an update flag, this tracks whether or not we have update the table after each step.
    bool update = true;

    // we terminate when the table has not been updated for one iteration (the same row is produced twice)
    while(update){
        update = false;

        // for each operator (only 1 in this example, but just incase!)
        for (size_t i = 0; i < g_operators.size(); i++){
            Operator &c_op = g_operators[i];
            // pull out the preconditions
            Tuple pre;
            get_operator_pre(c_op, pre);

            // evaluate the precondition costs
            int old_c = eval(pre);
        
            // if they aren't currently achievable, stop here.
            if (old_c != numeric_limits<int>::max()){
                // otherwise pull out the effects and for each partial tuple amongst them, update the table
                Tuple eff;
                get_operator_eff(c_op, eff);

                vector<Tuple> parts;
                generate_all_partial_tuples(eff, parts);

                // cost of tuple is the precondition cost plus action cost
                int cost = c_op.get_cost() + old_c;
    
                for (size_t j = 0; j < parts.size(); j++){
                    // logic to correctly maintain update flag
                    if (update) {
                        update_hm_entry(parts[j], cost);
                    } else {
                        update = update_hm_entry(parts[j], cost);
                    }
                    // if required, also attempt to update extendable tuples
                    if (parts[j].size() < m){
                        bool update2 = extend_tuple(parts[j], c_op);
                        update = update2 or update;
                    }
                }
            }
        }
    }
}

bool HMHeuristic::extend_tuple(Tuple &new_tup, Operator &op){
    op.get_effects();
    
    // check each column in the hm table
    for (auto const& hm_entry : hm_table) {
        const Tuple &col = hm_entry.first;
        // check that it contains new_tup
        bool contained = check_tuple_in_tuple(new_tup, col) == 0;
        // check that it is not exactly new_tup
        bool different = new_tup.size() < col.size();

        // check for contradictions between effects of op and column predicate
        bool contradicts = false;

        for (int t = 0; t < col.size(); t++){
            if (contradict_effect_of(op, col[t].first, col[t].second)){
                contradicts = true;
                break;
            }
        }

        Tuple pres;
        get_operator_pre(op, pres);
    
        // check that preconditions of action do not contradict the column predicate
        bool valid = true;

        if (contained and different and not contradicts){
            // determine validity.
            // {preconditions} U {col} must be internally consistent
            for (const pair<int,int> &col_fact : col){
                for (const pair<int,int> &pre_fact : pres){
                    if ((col_fact.first == pre_fact.first) and col_fact.second != pre_fact.second){
                        valid = false;
                        break;
                    }
                }
            }
        }
        
        if (valid) {
            // if all conditions are satisfied, add the precondition costs to the action
            int pre_cost = eval(pres) + op.get_cost();
            if (pre_cost != numeric_limits<int>::max()) {

                // I was getting a bug to do with the const conditions of the function.
                // creating a fresh tuple and using that fixes it. I have no idea why.
                Tuple add_t;
                for (pair<int,int> temp_tup : col){
                    add_t.push_back(temp_tup);
                }
                // update the hm table
                bool up = update_hm_entry(add_t, pre_cost);
                return up;
            }
        }
    }
    return false;
}


int HMHeuristic::eval(Tuple &t) const {
    
    vector<Tuple> partial;
    generate_all_partial_tuples(t, partial);
    
    int max = 0;

    // Find and return the maximum cost amongst partial tuples of t
    for (int i = 0; i < partial.size(); i++){
        int curr_val = hm_table.at(partial[i]);
        if (curr_val > max){
            max = curr_val;
        }
    }
    
    return max;
}


bool HMHeuristic::update_hm_entry(Tuple &t, int val){
    // make sure the column t exists in the table
    assert(hm_table.count(t) == 1);
    // then, if the new val is better than the previous one, update the table and return true
    if (hm_table[t] > val) {
        hm_table[t] = val;
        return true;
    }
    // otherwise false
    return false;
}


int HMHeuristic::check_tuple_in_tuple(
  //Check if tuple belongs to the higher level tuple
  //return infinite if not found, 0 if found.
    const Tuple &tup, const Tuple &big_tuple) const {
    for (size_t i = 0; i < tup.size(); ++i) {
        bool found = false;
        for (size_t j = 0; j < big_tuple.size(); ++j) {
            if (tup[i] == big_tuple[j]) {
                found = true;
                break;
            }
        }
        if (!found) {
            return numeric_limits<int>::max();
        }
    }
    return 0;
}


void HMHeuristic::state_to_tuple(const State &state, Tuple &t) const {
    for (size_t i = 0; i < g_variable_domain.size(); ++i)
        t.push_back(make_pair(i, state[i]));
}


int HMHeuristic::get_operator_pre_value(
    const Operator &op, int var) const {
    for (size_t i = 0; i < op.get_preconditions().size(); ++i) {
        if (op.get_preconditions()[i].var == var)
            return op.get_preconditions()[i].val;
    }
    return -1;
}


void HMHeuristic::get_operator_pre(const Operator &op, Tuple &t) const {
    for (size_t i = 0; i < op.get_preconditions().size(); ++i)
        t.push_back(make_pair(op.get_preconditions()[i].var,
                              op.get_preconditions()[i].val));
    sort(t.begin(), t.end());
}


void HMHeuristic::get_operator_eff(const Operator &op, Tuple &t) const {
    for (size_t i = 0; i < op.get_effects().size(); ++i)
        t.push_back(make_pair(op.get_effects()[i].var,
                              op.get_effects()[i].val));
    sort(t.begin(), t.end());
}


bool HMHeuristic::is_pre_of(const Operator &op, int var) const {
    // TODO if preconditions will be always sorted we should use a log-n
    // search instead
    for (size_t j = 0; j < op.get_preconditions().size(); ++j) {
        if (op.get_preconditions()[j].var == var) {
            return true;
        }
    }
    return false;
}


bool HMHeuristic::is_effect_of(const Operator &op, int var) const {
    for (size_t j = 0; j < op.get_effects().size(); ++j) {
        if (op.get_effects()[j].var == var) {
            return true;
        }
    }
    return false;
}


bool HMHeuristic::contradict_effect_of(
    const Operator &op, int var, int val) const {
    for (size_t j = 0; j < op.get_effects().size(); ++j) {
        if (op.get_effects()[j].var == var && op.get_effects()[j].val != val) {
            return true;
        }
    }
    return false;
}


void HMHeuristic::generate_all_tuples() {
    Tuple t;
    generate_all_tuples_aux(0, m, t);
}


void HMHeuristic::generate_all_tuples_aux(int var, int sz, Tuple &base) {
    int num_variables = g_variable_domain.size();
    for (int i = var; i < num_variables; ++i) {
        for (int j = 0; j < g_variable_domain[i]; ++j) {
            Tuple tup(base);
            tup.push_back(make_pair(i, j));
            hm_table[tup] = 0;
            if (sz > 1) {
                generate_all_tuples_aux(i + 1, sz - 1, tup);
            }
        }
    }
}


void HMHeuristic::generate_all_partial_tuples(
    Tuple &base_tuple, vector<Tuple> &res) const {
    Tuple t;
    generate_all_partial_tuples_aux(base_tuple, t, 0, m, res);
}


void HMHeuristic::generate_all_partial_tuples_aux(
    Tuple &base_tuple, Tuple &t, int index, int sz, vector<Tuple> &res) const {
    if (sz == 1) {
        for (size_t i = index; i < base_tuple.size(); ++i) {
            Tuple tup(t);
            tup.push_back(base_tuple[i]);
            res.push_back(tup);
        }
    } else {
        for (size_t i = index; i < base_tuple.size(); ++i) {
            Tuple tup(t);
            tup.push_back(base_tuple[i]);
            res.push_back(tup);
            generate_all_partial_tuples_aux(base_tuple, tup, i + 1, sz - 1, res);
        }
    }
}


void HMHeuristic::dump_table() const {
    cout << "DUMPING H TABLE" << endl;
    map<Tuple, int>::const_iterator it;
    for (it = hm_table.begin(); it != hm_table.end(); ++it) {
        pair<Tuple, int> hm_ent = *it;
        cout << "h[";
        dump_tuple(hm_ent.first);
        cout << "] = " << hm_ent.second << endl;
    }
}


void HMHeuristic::dump_tuple(Tuple &tup) const {
    cout << g_fact_names[tup[0].first][tup[0].second];
    for (size_t i = 1; i < tup.size(); ++i)
        cout << "," <<  g_fact_names[tup[i].first][tup[i].second];

}


static Heuristic *_parse(OptionParser &parser) {
    parser.document_synopsis("h^m heuristic", "");
    parser.document_language_support("action costs", "supported");
    parser.document_language_support("conditional effects", "ignored");
    parser.document_language_support("axioms", "ignored");
    parser.document_property("admissible",
                             "yes for tasks without conditional "
                             "effects or axioms");
    parser.document_property("consistent",
                             "yes for tasks without conditional "
                             "effects or axioms");

    parser.document_property("safe",
                             "yes for tasks without conditional "
                             "effects or axioms");
    parser.document_property("preferred operators", "no");

    parser.add_option<int>("m", "subset size", "2");
    Heuristic::add_options_to_parser(parser);
    Options opts = parser.parse();
    if (parser.dry_run())
        return 0;
    else
        return new HMHeuristic(opts);
}


static Plugin<Heuristic> _plugin("hm", _parse);
