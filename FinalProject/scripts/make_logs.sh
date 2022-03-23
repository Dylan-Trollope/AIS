rm -rf logs
mkdir logs
# P01 blind
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(blind(), w=1)" >> logs/p01.log
# P02 blind
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(blind(), w=1)" >> logs/p02.log
# P01 gc
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(gc(), w=1)" >> logs/p01-goal-count.log
# P02 gc
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(gc(), w=1)" >> logs/p02-goal-count.log
# P01 h1
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(hm(1), w=1)" >> logs/p01-h1.log
# P02 h1
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(hm(1), w=1)" >> logs/p02-h1.log
# P01 h2
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(hm(2), w=1)" >> logs/p01-h2.log
# P02 h2
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(hm(2), w=1)" >> logs/p02-h2.log

