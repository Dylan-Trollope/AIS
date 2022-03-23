python3.8 grid_maker.py $1 $2 > new_prob.pddl
./do_plan.sh light_up_domain.pddl new_prob.pddl
python3.8 lightup_gifipy/gifi.py -p new_prob.pddl -s sas_plan



