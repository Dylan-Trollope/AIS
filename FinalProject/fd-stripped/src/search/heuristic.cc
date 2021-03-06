#include "heuristic.h"

#include "operator.h"
#include "option_parser.h"
#include "operator_cost.h"

#include <cassert>
#include <cstdlib>
#include <limits>

using namespace std;

Heuristic::Heuristic(const Options &opts)
    : cost_type(OperatorCost(opts.get_enum("cost_type")))
{
    heuristic = NOT_INITIALIZED;
}

Heuristic::~Heuristic()
{
}

void Heuristic::evaluate(const State &state)
{
    if (heuristic == NOT_INITIALIZED) {
        initialize();
    }
    heuristic = compute_heuristic(state);
    assert(heuristic == DEAD_END || heuristic >= 0);
    evaluator_value = heuristic;
}

bool Heuristic::is_dead_end() const
{
    return evaluator_value == DEAD_END;
}

int Heuristic::get_heuristic()
{
    // The -1 value for dead ends is an implementation detail which is
    // not supposed to leak. Thus, calling this for dead ends is an
    // error. Call "is_dead_end()" first.

    /*
      TODO: I've commented the assertion out for now because there is
      currently code that calls get_heuristic for dead ends. For
      example, if we use alternation with h^FF and h^cea and have an
      instance where the initial state has infinite h^cea value, we
      should expand this state since h^cea is unreliable. The search
      progress class will then want to print the h^cea value of the
      initial state since this is the "best know h^cea state" so far.

      However, we should clean up the code again so that the assertion
      is valid or rethink the interface so that we don't need it.
     */

    // assert(heuristic >= 0);
    if (heuristic == DEAD_END) {
        return numeric_limits<int>::max();
    }
    return heuristic;
}

void Heuristic::get_helpful_actions(std::vector<const Operator *> &)
{
}

void Heuristic::reach_state(const State & /*parent_state*/,
                            const Operator & /*op*/, const State & /*state*/)
{
}

int Heuristic::get_value() const
{
    return evaluator_value;
}

void Heuristic::evaluate(int, bool)
{
    return;
    // if this is called, evaluate(const State &state) or set_evaluator_value(int val)
    // should already have been called
}

bool Heuristic::dead_end_is_reliable() const
{
    return dead_ends_are_reliable();
}

void Heuristic::set_evaluator_value(int val)
{
    evaluator_value = val;
}

int Heuristic::get_adjusted_cost(const Operator &op) const
{
    return get_adjusted_action_cost(op, cost_type);
}

void Heuristic::add_options_to_parser(OptionParser &parser)
{
    ::add_cost_type_option_to_parser(parser);
}

//this solution to get default values seems not optimal:
Options Heuristic::default_options()
{
    Options opts = Options();
    opts.set<int>("cost_type", 0);
    return opts;
}
