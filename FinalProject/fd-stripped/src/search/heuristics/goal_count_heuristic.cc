#include "goal_count_heuristic.h"

#include "../globals.h"
#include "../operator.h"
#include "../option_parser.h"
#include "../plugin.h"
#include "../state.h"


using namespace std;

GoalCountHeuristic::GoalCountHeuristic(const Options &opts)
    : Heuristic(opts)
{
}

void GoalCountHeuristic::initialize()
{
    cout << "Initializing goal counting heuristic..." << endl;
}

int GoalCountHeuristic::compute_heuristic(const State &state)
{

    /* 
        g_goal is a vector storing individual (predicate, state) tuples
        predicate - the predicate concerned e.g. lit(x1, y2)
        state - "lit(x1, y2)" or "negated literal lit(x1, y2)"

        .size() gets size of goal state (number of predicates it contains)
    */
    size_t goal_count = g_goal.size();    

    // for each i in the goal state
    for (size_t i = 0; i < g_goal.size(); ++i) {
        /*
            state[k] contains an integer representing the STATE that the Kth predicate is in (0|1)
            g_goal[l] is a tuple, as described prior.

            We compare the desired state of ith predicate in the goal (g_goal[i].second)
                to the current state of that predicate (state[g_goal[i].first]
            If they are the same, then that sub-goal is satisfied and we reduce goal count by 1
        */
        if (state[g_goal[i].first] == g_goal[i].second) {
            --goal_count;       
        }
    }
    
    return goal_count;
}

static Heuristic *_parse(OptionParser &parser)
{
    Heuristic::add_options_to_parser(parser);
    Options opts = parser.parse();
    if (parser.dry_run()) {
        return 0;
    } else {
        return new GoalCountHeuristic(opts);
    }
}

static Plugin<Heuristic> _plugin("gc", _parse);
