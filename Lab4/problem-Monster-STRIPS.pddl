(define (problem Monster-a-1)
	(:domain Monster-a)
	(:objects
		sq-1-1 sq-1-2 sq-1-3
		sq-2-1 sq-2-2 sq-2-3
		the-gold
		the-arrow
		agent
		monster)

	(:init 
		(adj sq-1-1 sq-1-2) (adj sq-1-2 sq-1-1)
		(adj sq-1-2 sq-1-3) (adj sq-1-3 sq-1-2)
		(adj sq-2-1 sq-2-2) (adj sq-2-2 sq-2-1)
		(adj sq-2-2 sq-2-3) (adj sq-2-3 sq-2-2)
		(adj sq-1-1 sq-2-1) (adj sq-2-1 sq-1-1)
		(adj sq-1-2 sq-2-2) (adj sq-2-2 sq-1-2)
		(adj sq-1-3 sq-2-3) (adj sq-2-3 sq-1-3)

		(pit sq-1-2)
	
		(at the-gold sq-1-3)
		(at agent sq-1-1)
		(have agent the-arrow)
		(at monster sq-2-3)
		(agency agent))

	(:goal (and (have agent the-gold) (dead monster) (at agent sq-1-1))))
