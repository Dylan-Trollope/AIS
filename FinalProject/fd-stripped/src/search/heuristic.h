#ifndef HEURISTIC_H
#define HEURISTIC_H

#include "scalar_evaluator.h"
#include "operator_cost.h"

#include <map>
#include <set>
#include <string>
#include <vector>

class Operator;
class State;
class OptionParser;
class Options;

class Heuristic : public ScalarEvaluator
{
    enum {NOT_INITIALIZED = -2};
    int heuristic;
    int evaluator_value; // usually equal to heuristic but can be different
    // if set with set_evaluator_value which is done if we use precalculated
    // estimates, eg. when re-opening a search node

protected:
    OperatorCost cost_type;
    enum {DEAD_END = -1};
    virtual void initialize() {}
    virtual int compute_heuristic(const State &state) = 0;
    int get_adjusted_cost(const Operator &op) const;
public:
    Heuristic(const Options &options);
    virtual ~Heuristic();

    void evaluate(const State &state);
    bool is_dead_end() const;
    int get_heuristic();
    virtual void get_helpful_actions(std::vector<const Operator *> &result);
    virtual bool dead_ends_are_reliable() const
    {
        return true;
    }
    virtual void reach_state(const State &parent_state, const Operator &op,
                             const State &state);

    // for abstract parent ScalarEvaluator
    int get_value() const;
    void evaluate(int g, bool preferred);
    bool dead_end_is_reliable() const;
    void set_evaluator_value(int val);
    void get_involved_heuristics(std::set<Heuristic *> &hset)
    {
        hset.insert(this);
    }
    OperatorCost get_cost_type() const
    {
        return cost_type;
    }

    static void add_options_to_parser(OptionParser &parser);
    static Options default_options();
};

#endif
