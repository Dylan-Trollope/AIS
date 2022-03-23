echo ""
echo "P1 BLIND"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(blind(), w=1)" | grep "Total time"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(blind(), w=1)" | grep "Expanded"

echo ""
echo "P2 BLIND"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(blind(), w=1)" | grep "Total time"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(blind(), w=1)" | grep "Expanded"

echo ""
echo "P1 GC"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(gc(), w=1)" | grep "Total time"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(gc(), w=1)" | grep "Expanded"

echo ""
echo "P2 GC"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(gc(), w=1)" | grep "Total time"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(gc(), w=1)" | grep "Expanded"

echo ""
echo "P1 H1"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(hm(1), w=1)" | grep "Total time"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(hm(1), w=1)" | grep "Expanded"

echo ""
echo "P2 H1"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(hm(1), w=1)" | grep "Total time"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(hm(1), w=1)" | grep "Expanded"

echo ""
echo "P1 H2"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(hm(2), w=1)" | grep "Total time"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(hm(2), w=1)" | grep "Expanded"

echo ""
echo "P2 H2"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(hm(2), w=1)" | grep "Total time"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(hm(2), w=1)" | grep "Expanded"


