(define (domain Light-Up-Domain)
    (:requirements :adl :typing)
    (:types xpos ypos num - object)
    (:predicates    (increment ?n1 ?n2 - num) ; used to count number of lightbulbs (0-4) 
                    (adjacent ?x1 - xpos ?y1 - ypos ?x2 - xpos ?y2 - ypos) ; (x1, y1) is adjacent to (x2, y2)
                    (right ?x1 ?x2 - xpos) ; x1 is to the right of x2
                    (left ?x1 ?x2 - xpos) ; x1 is to the left of x2
                    (up ?y1 ?y2 - ypos) ; x1 is above x2
                    (below ?y1 ?y2 - ypos) ; x1 is below x2
                    (lit ?x - xpos ?y - ypos) ; (x, y) is lit up
                    (black ?x1 - xpos ?y1 - ypos) ; (x1, y1) is a black block
                    (surrounded ?x1 - xpos ?y1 - ypos ?n - num) ; the amount of lightbulbs surrounding a black block 
    )
    
	
	; As recommended, there is only one action, light-up, which is parameterised by (x, y) - the coordinate of the block
	; in which to place the lightbulb

	; PRECONDITIONS
	; Lightbulbs can not be placed on blocks that are black or lit up

	; EFFECTS
	; When a lightbulb is placed at (x,y), light up (x,y), also;
	; 	light up every block that is:
	; 	a)	to the right of the lightbulb only if there is not a black block which is to the right of the lightbulb 
	; 		and also to the left of the current block being lit
	;   b)  to the left of the lightbulb only if there is not a black block which is to the left of the lightbulb
	;		and also to the right of the current block being lit
	;   c)  above the lighbulb only if there is not a black block which is above the lightbulb and also below the
	;		current block being lit
	;	d)  below the lightbulb only if there is not a black blok which is below the lightbulb and also above the 
	;		current block being lit
	;
	; When a lightbulb is placed adjacent to a black block that needs to be surrounded by ?n2 lighbulbs,
	; Increment the surrounded predicate from ?n1 to ?n2 (using increment ?n1 ?n2
	;
			

    (:action light-up
        :parameters (?x - xpos ?y - ypos)
        :precondition (and
            (not (lit ?x ?y))
            (not (black ?x ?y))
        )
        :effect (and
            ; RIGHT
            (forall (?x2 - xpos) 
                (when 
                    (and 
                        (right ?x2 ?x) 
                        (not (exists (?xb - xpos) (and (black ?xb ?y) (right ?xb ?x) (left ?xb ?x2)) ))
                    )
                    (lit ?x2 ?y)
                )
            )
            ; LEFT
            (forall (?x2 - xpos) 
                (when 
                    (and 
                        (left ?x2 ?x) 
                        (not (exists (?xb - xpos) (and (black ?xb ?y) (left ?xb ?x) (right ?xb ?x2)) ))
                    )
                    (lit ?x2 ?y)
                )
            )
            ; UP
            (forall (?y2 - ypos) 
                (when 
                    (and 
                        (up ?y2 ?y) 
                        (not (exists (?yb - ypos) (and (black ?x ?yb) (up ?yb ?y) (below ?yb ?y2)) ))
                    )
                    (lit ?x ?y2)
                )
            )
            ; DOWN
            (forall (?y2 - ypos) 
                (when 
                    (and 
                        (below ?y2 ?y) 
                        (not (exists (?yb - ypos) (and (black ?x ?yb) (below ?yb ?y) (up ?yb ?y2)) ))
                    )
                    (lit ?x ?y2)
                )
            )
            (forall (?x2 - xpos ?y2 - ypos ?n1 ?n2 - num) 
                (when (and
                        (adjacent ?x ?y ?x2 ?y2)
                        (black ?x2 ?y2)
                        (increment ?n1 ?n2)
                        (surrounded ?x2 ?y2 ?n1)
                      )
                      (and
                          (not (surrounded ?x2 ?y2 ?n1))
                          (surrounded ?x2 ?y2 ?n2)
                      )
                )
            )
            (lit ?x ?y)
        )
    )
    
)


