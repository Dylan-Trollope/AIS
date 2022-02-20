(define (domain Carving)
	(:requirements strips)

	(:predicates	(looking ?x)
			(available ?c)
			(hand ?h)
			(design ?p ?c))

	(:action look_at
		:parameters (?pumpkin)
		:precondition ()
		:effect (looking ?pumpkin))

	(:action pick_up
		:parameters (?hand ?tool)
		:precondition (and (available ?tool)
			           (?hand)
		:effect (	
				
