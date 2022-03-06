;domain file for Monster world (STRIPS version)

(define (domain Monster-a)
	(:requirements :strips)

	(:predicates
		(adj ?square-1 ?square-2)
		(pit ?square)
		(at ?what ?square)
		(have ?who ?what)
		(dead ?who)
		(monster ?square)
		(agency ?agent))
	
	(:action move
		:parameters (?who ?from ?to)
		:precondition (and (adj ?from ?to)
			      (not (pit ?to))
			      (not (monster ?to))
			      (agency ?who)
			      (at ?who ?from))
		:effect (and (not (at ?who ?from)) (at ?who ?to)))

	(:action take
		:parameters (?who ?what ?where)
		:precondition (and (at ?who ?where) (at ?what ?where))
		:effect (and (have ?who ?what) (not (at ?what ?where))))

	(:action shoot
		:parameters (?who ?where ?arrow ?where-victim)
		:precondition (and (have ?who ?arrow)
			      (at ?who ?where)
			      (agency ?who)
			      (monster ?where-victim)
			      (adj ?where ?where-victim))
		:effect (and 
			(not (monster ?where-victim))
			(not (have ?who ?arrow))))

)


