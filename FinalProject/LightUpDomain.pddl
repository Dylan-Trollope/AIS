(define 
	(domain LightUp)
	(:requirements :adl :typing)

	(:types xpos ypos num - object)

	(:predicates	(increment ?n1 ?n2 - num)
			(adjacent ?x - xpos ?y - ypos ?x2 - xpos ?y2 - ypos)
			(right ?x1 ?x2 - xpos)
			(left ?x1 ?x2 - xpos)
			(below ?y1 ?y2 - ypos)
			(above ?y1 ?y2 - ypos)
			(lit ?x - xpos ?y - ypos)
			(black ?x - xpos ?y - ypos)
			(surrounded ?x - xpos ?y - ypos ?n - num)


	)

	(:action place-bulb
		:parameters (?x - xpos ?y - ypos)

		:precondition (and (not (lit ?x ?y)) (not (black ?x ?y)))
				   
		:effect (and 
				(lit ?x ?y)

				(forall (?r - xpos)
					(when (and 
					  (right ?r ?x) 
					    (not (exists (?l - xpos) (and (black ?l ?y) (right ?l ?x) (left ?l ?r)))))
								(lit ?r ?y)
					)
				)

				(forall (?l - xpos)
					(when (and 
						(left ?l ?x)
							(not (exists (?r - xpos) (and (black ?r ?y) (left ?r ?x) (right ?r ?l)))))
								(lit ?l ?y)
					)
				)

				(forall (?b - ypos)
					(when (and 
						(below ?b ?y) 
							(not (exists (?a - ypos) (and (black ?x ?a) (below ?a ?y) (above ?a ?b)))))
								(lit ?x ?b)
					)
				)

				(forall (?a - ypos)
					(when (and
						(above ?a ?y)
							(not (exists (?b - ypos) (and (black ?x ?b) (above ?b ?y) (below ?b ?a)))))
								(lit ?x ?a)
					)
				)

			)

	)

			;(forall (?r - xpos) (when (or (right ?r ?x) (left ?r ?x)) (lit ?r ?y)))
			;(forall (?d - ypos) (when (or (above ?d ?y) (below ?d ?y)) (lit ?x ?d)))))

			

)
