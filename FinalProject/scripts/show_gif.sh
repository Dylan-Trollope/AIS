./new_prob.sh $1 $2 "wastar(gc(), w=1)"
python3.8 lightup_gifipy/gifi.py -p new_prob.pddl -s sas_plan
xdg-open plan.gif
