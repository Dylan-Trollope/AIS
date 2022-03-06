(define (domain Carving)
	(:requirements :strips :typing)

	(:types hand pumpkin tool - object)


	(:predicates	(looking ?x - pumpkin) 
			(design ?p - pumpkin ?c - tool)
			(available ?c - tool)
			(hand ?h - hand ?c - tool)
			(empty ?h - hand)
			(tool ?t - tool ?h - hand))


	(:action look_at
		:parameters (?current - pumpkin ?next - pumpkin)
		:precondition (looking ?current)
		:effect (and (looking ?next) (not (looking ?current))))

	(:action pick_up
		:parameters (?hand - hand ?tool - tool)
		:precondition (forall (?tool - tool) (not (tool ?tool ?hand)))
		:effect (and (not (empty ?hand)) (tool ?tool ?hand)))

	(:action drop
		:parameters (?tool - tool ?hand - hand)
		:precondition (and (tool ?tool ?hand) (not (empty ?hand)))
		:effect (and (empty ?hand) (not (tool ?tool ?hand))))
	
	(:action carve
		:parameters (?pumpkin - pumpkin ?tool - tool ?hand - hand)
		:precondition (and (tool ?tool ?hand) (looking ?pumpkin))
		:effect (design ?pumpkin ?tool)))
		
		
