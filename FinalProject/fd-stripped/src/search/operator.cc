#include "operator.h"

#include "globals.h"

#include <algorithm>
#include <iostream>

using namespace std;

Condition::Condition(istream &in) {
    in >> var >> val;
}

void Operator::read_pre_post(istream &in) {
    int cond_count, var, pre, post;
    in >> cond_count;
    vector<Condition> conditions;
    conditions.reserve(cond_count);
    for (int i = 0; i < cond_count; ++i)
        conditions.push_back(Condition(in));
    in >> var >> pre >> post;
    if (pre != -1)
        preconditions.push_back(Condition(var, pre));
    effects.push_back(Effect(var, post, conditions));
}

Operator::Operator(istream &in, bool axiom) {
    marked = false;

    is_an_axiom = axiom;
    if (!is_an_axiom) {
        check_magic(in, "begin_operator");
        in >> ws;
        getline(in, name);
        int count;
        in >> count;
        for (int i = 0; i < count; ++i)
            preconditions.push_back(Condition(in));
        in >> count;
        for (int i = 0; i < count; ++i)
            read_pre_post(in);

        int op_cost;
        in >> op_cost;
        cost = g_use_metric ? op_cost : 1;

        g_min_action_cost = min(g_min_action_cost, cost);
        g_max_action_cost = max(g_max_action_cost, cost);

        check_magic(in, "end_operator");
    } else {
        name = "<axiom>";
        cost = 0;
        check_magic(in, "begin_rule");
        read_pre_post(in);
        check_magic(in, "end_rule");
    }

    marker1 = marker2 = false;
}

void Condition::dump() const {
    cout << g_variable_name[var] << ": " << val;
}

void Effect::dump() const {
    cout << g_variable_name[var] << ":= " << val;
    if (!conditions.empty()) {
        cout << " if";
        for (size_t i = 0; i < conditions.size(); ++i) {
            cout << " ";
            conditions[i].dump();
        }
    }
}

void Operator::dump() const {
    cout << name << ":";
    for (size_t i = 0; i < preconditions.size(); ++i) {
        cout << " [";
        preconditions[i].dump();
        cout << "]";
    }
    for (size_t i = 0; i < effects.size(); ++i) {
        cout << " [";
        effects[i].dump();
        cout << "]";
    }
    cout << endl;
}
