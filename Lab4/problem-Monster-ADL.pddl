(define (problem Monster-c-1)
	(:domain Monster-c)
	(:objects
		sq-1-1 sq-1-2 sq-1-3
		sq-2-1 sq-2-2 sq-2-3 - square
		the-gold 
		the-arrow - takeable
		agent - agent
		monster - monst)

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
		(at monster sq-2-3))

	(:goal (and (have agent the-gold) (at agent sq-1-1))))
