echo ""
echo "P1 BLIND"

for k in 1 10 20 30 40 50 60 70 80 90 100
do
echo "wastar(blind(), w=$k)..."
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(blind(), w=$k)" | grep "Plan length"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(blind(), w=$k)" | grep "Expanded"
done

echo "---------------------------------------------------------------------------------------"

echo ""
echo "P1 GC"

for k in 1 10 20 30 40 50 60 70 80 90 100
do
echo "wastar(gc(), w=$k)..."
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(gc(), w=$k)" | grep "Plan length"
./do_plan.sh light_up_domain.pddl example1_readable.pddl "wastar(gc(), w=$k)" | grep "Expanded"
done

echo "---------------------------------------------------------------------------------------"

echo ""
echo "P2 BLIND"

for k in 1 10 20 30 40 50 60 70 80 90 100
do
echo "wastar(blind(), w=$k)..."
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(blind(), w=$k)" | grep "Plan length"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(blind(), w=$k)" | grep "Expanded"
done

echo "---------------------------------------------------------------------------------------"

echo ""
echo "P2 GC"

for k in 1 10 20 30 40 50 60 70 80 90 100
do
echo "wastar(gc(), w=$k)..."
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(gc(), w=$k)" | grep "Plan length"
./do_plan.sh light_up_domain.pddl example2_readable.pddl "wastar(gc(), w=$k)" | grep "Expanded"
done

echo "---------------------------------------------------------------------------------------"
