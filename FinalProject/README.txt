This is the directory containing PDDL and modified fd-stripped
Written by Jack Pellen-Pickersgill and Dylan Trollope

This directory includes:
	example1_readable.pddl - the PDDL problem file for p01
	example2_readable.pddl - the PDDL problem file for p02
	light_up_domain.pddl - the domain file used to solve any light-up puzzle
	logs/ - The directory containing all logs produced by running fast-downward using various heuristics 
	on p01 and p02
	fd-stripped/ - 	directory containing modified fast-downward planning code with included implementations of
			the following heuristics:
		
			Goal Count heuristic found in: goal_count_heuristic.cc/.h
			H1 and H2 heuristic found in: hm_heuristic_handout.cc/.h


Code in hm_heuristic_handout.cc is adapted from the Artificial Intelligence Group - University of Basel, found at:
https://github.com/aibasel/downward
	
