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

		:precondition (not (lit ?x ?y))
				   
		:effect (and 
			(forall (?xs - xpos ?ys - ypos)
			(when (and (right ?xs ?x) (below ?ys ?y))
			(and (lit ?xs ?y) (lit ?x ?ys))))

			(forall (?xs - xpos ?ys - ypos)
			(when (and (right ?xs ?x) (below ?ys ?y))
			(and (lit ?xs ?y) (lit ?x ?ys)))))


	)
)
