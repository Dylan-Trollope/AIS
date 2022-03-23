(define (problem Light-Up-Problem)
    (:domain Light-Up-Domain)
    (:objects 
	
	; 5 x 5 grid described by (xpos, ypos) coordinates
	; num describes number of lightbulbs currently surrounding a black block 	
	
        N0 N1 N2 N3 N4 - num
	X0 X1 X2 X3 X4 - xpos
	Y0 Y1 Y2 Y3 Y4 - ypos

    )
    (:init 

	; Facts used to increase the counter of num (lightbulbs)

        (increment N0 N1)
        (increment N1 N2)
        (increment N2 N3)
        (increment N3 N4)

	; Adjacency of all (xpos, ypos) cooordinates are described here
	; i.e (X0, Y0) is adjacent to (X1, Y0) and (X0, Y1)

	(adjacent X0 Y0 X1 Y0) (adjacent X0 Y0 X0 Y1) 
	(adjacent X0 Y1 X0 Y0) (adjacent X0 Y1 X1 Y1) (adjacent X0 Y1 X0 Y2)
	(adjacent X0 Y2 X0 Y1) (adjacent X0 Y2 X1 Y2) (adjacent X0 Y2 X0 Y3)
	(adjacent X0 Y3 X0 Y2) (adjacent X0 Y3 X1 Y3) (adjacent X0 Y3 X0 Y4)
	(adjacent X0 Y4 X0 Y3) (adjacent X0 Y4 X1 Y4) 
	(adjacent X1 Y0 X0 Y0) (adjacent X1 Y0 X2 Y0) (adjacent X1 Y0 X1 Y1)
	(adjacent X1 Y1 X0 Y1) (adjacent X1 Y1 X1 Y0) (adjacent X1 Y1 X2 Y1) (adjacent X1 Y1 X1 Y2)
	(adjacent X1 Y2 X0 Y2) (adjacent X1 Y2 X1 Y1) (adjacent X1 Y2 X2 Y2) (adjacent X1 Y2 X1 Y3)
	(adjacent X1 Y3 X0 Y3) (adjacent X1 Y3 X1 Y2) (adjacent X1 Y3 X2 Y3) (adjacent X1 Y3 X1 Y4)
	(adjacent X1 Y4 X0 Y4) (adjacent X1 Y4 X1 Y3) (adjacent X1 Y4 X2 Y4)
	(adjacent X2 Y0 X1 Y0) (adjacent X2 Y0 X3 Y0) (adjacent X2 Y0 X2 Y1)
	(adjacent X2 Y1 X1 Y1) (adjacent X2 Y1 X2 Y0) (adjacent X2 Y1 X3 Y1) (adjacent X2 Y1 X2 Y2)
	(adjacent X2 Y2 X1 Y2) (adjacent X2 Y2 X2 Y1) (adjacent X2 Y2 X3 Y2) (adjacent X2 Y2 X2 Y3)
	(adjacent X2 Y3 X1 Y3) (adjacent X2 Y3 X2 Y2) (adjacent X2 Y3 X3 Y3) (adjacent X2 Y3 X2 Y4)
	(adjacent X2 Y4 X1 Y4) (adjacent X2 Y4 X2 Y3) (adjacent X2 Y4 X3 Y4)
	(adjacent X3 Y0 X2 Y0) (adjacent X3 Y0 X4 Y0) (adjacent X3 Y0 X3 Y1) 
	(adjacent X3 Y1 X2 Y1) (adjacent X3 Y1 X3 Y0) (adjacent X3 Y1 X4 Y1) (adjacent X3 Y1 X3 Y2)
	(adjacent X3 Y2 X2 Y2) (adjacent X3 Y2 X3 Y1) (adjacent X3 Y2 X4 Y2) (adjacent X3 Y2 X3 Y3)
	(adjacent X3 Y3 X2 Y3) (adjacent X3 Y3 X3 Y2) (adjacent X3 Y3 X4 Y3) (adjacent X3 Y3 X3 Y4)
	(adjacent X3 Y4 X2 Y4) (adjacent X3 Y4 X3 Y3) (adjacent X3 Y4 X4 Y4) 
	(adjacent X4 Y0 X3 Y0) (adjacent X4 Y0 X4 Y1)
	(adjacent X4 Y1 X3 Y1) (adjacent X4 Y1 X4 Y0) (adjacent X4 Y1 X4 Y2)
	(adjacent X4 Y2 X3 Y2) (adjacent X4 Y2 X4 Y1) (adjacent X4 Y2 X4 Y3)
	(adjacent X4 Y3 X3 Y3) (adjacent X4 Y3 X4 Y2) (adjacent X4 Y3 X4 Y4) 
	(adjacent X4 Y4 X3 Y4) (adjacent X4 Y4 X4 Y3)

	; Describes (xpos, ypos) in terms of relative position to other coordinates
	; Used when propagating light after a place-bulb ?x ?y action is executed
	; i.e., Assuming a grid has no black blocks, the (right ?rx ?x) predicate is used to
	; light up all coordinates ?rx for the current ?y


	(right X1 X0) (left X0 X1) (up Y0 Y1) (below Y1 Y0)
	(right X2 X0) (left X0 X2) (up Y0 Y2) (below Y2 Y0)
	(right X2 X1) (left X1 X2) (up Y1 Y2) (below Y2 Y1)
	(right X3 X0) (left X0 X3) (up Y0 Y3) (below Y3 Y0)
	(right X3 X1) (left X1 X3) (up Y1 Y3) (below Y3 Y1) 
	(right X3 X2) (left X2 X3) (up Y2 Y3) (below Y3 Y2)
	(right X4 X0) (left X0 X4) (up Y0 Y4) (below Y4 Y0)
	(right X4 X1) (left X1 X4) (up Y1 Y4) (below Y4 Y1)
	(right X4 X2) (left X2 X4) (up Y2 Y4) (below Y4 Y2)
	(right X4 X3) (left X3 X4) (up Y3 Y4) (below Y4 Y3)

	; (black ?x ?y) used to describe which blocks do not let light propagate through
	; Initially, no lightbulbs are placed, (surrounded ?x ?y N0) must hold for every ?x ?y

	(black X1 Y0)

	(black X1 Y1)
	(surrounded X1 Y1 N0)

	(black X1 Y3)
	(surrounded X1 Y3 N0)

	(black X3 Y1)
	(surrounded X3 Y1 N0)

	(black X4 Y1)

	(black X3 Y3)
	(surrounded X3 Y3 N0)
 
    )
    (:goal  ; every coordinate (xpos, ypos) must be lit or black
	    ; some cooridnates (xpos, ypos) are surrounded by some number (0-4) of lightbulbs

	    ( and 
            (lit x0 y0) (lit x1 y0) (lit x2 y0) (lit x3 y0) (lit x4 y0)
            (lit x0 y1)             (lit x2 y1)             (lit x4 y1)
            (lit x0 y2) (lit x1 y2) (lit x2 y2) (lit x3 y2) (lit x4 y2)
            (lit x0 y3)             (lit x2 y3)             (lit x4 y3)
            (lit x0 y4) (lit x1 y4) (lit x2 y4) (lit x3 y4) (lit x4 y4)

		    (surrounded X1 Y1 N1)
		    (surrounded X1 Y3 N2)
		    (surrounded X3 Y1 N2)
		    (surrounded X3 Y3 N2)
        )
    )
)


