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
					(when (and (right ?r ?x) (not (exists (?l - xpos) (and (black ?l ?y) (left ?l ?x)))))
						(lit ?r ?y)
					)
				)


				(forall (?b - ypos)
					(when (and (below ?b ?y) (not (exists (?a - ypos) (and (black ?x ?a) (above ?a ?y)))))
						(lit ?x ?b)
					)
				)

			)

	)

			;(forall (?r - xpos) (when (or (right ?r ?x) (left ?r ?x)) (lit ?r ?y)))
			;(forall (?d - ypos) (when (or (above ?d ?y) (below ?d ?y)) (lit ?x ?d)))))

			

)
