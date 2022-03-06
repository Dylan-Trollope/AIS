;domain file for Monster world (ADL version)

(define (domain Monster-c)
	(:requirements :strips :adl :typing)

	(:types monst agent takeable square - object)


	(:predicates
		(adj ?square1 ?square2)
		(pit ?square)
		(at ?what ?square)
		(have ?who ?what)
		(dead ?who))
	
	(:action move
		:parameters (?who - agent ?from - square ?to - square)
		:precondition (and (adj ?from ?to)
			      (not (dead ?who))
		              (not (exists (?mo - monst) (at ?mo ?to)))
                              (at ?who ?from))
                :effect (and (not (at ?who ?from)) (at ?who ?to)
			(when (pit ?to) (dead ?who))))


	(:action take
                :parameters (?who - agent ?what - takeable ?where - square)
                :precondition (and (at ?who ?where) (at ?what ?where))
                :effect (and (have ?who ?what) (not (at ?what ?where))))

        (:action shoot
                :parameters (?who - agent ?where - square ?arrow - takeable ?victim - monst ?where-victim - square)
                :precondition (and (have ?who ?arrow)
                              (at ?who ?where)
                              (at ?victim ?where-victim)
                              (adj ?where ?where-victim))
                :effect (and (dead ?victim)
			(not (at ?victim ?where-victim))
                        (not (have ?who ?arrow))))

)


