(define (domain Towers)
	(:requirements :strips)
	
	(:predicates (clear ?x)
		     (on ?x ?y)
		     (smaller ?x ?y))

	(:action move
		:parameters (?disk ?from ?to)
		:precondition (and 
				(clear ?disk)
				(clear ?to)
				(on ?disk ?from)
				(smaller ?disk ?to))

		:effect (and 
				(clear ?from)
				(on ?disk ?to)
				(not (on ?disk ?from))
				(not (clear ?to)))
	)
)


		

		
	 
