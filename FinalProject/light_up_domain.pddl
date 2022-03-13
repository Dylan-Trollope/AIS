(define (domain Light-Up-Domain)
    (:requirements :adl :typing)
    (:types xpos ypos num - object)
    (:predicates    (increment ?n1 ?n2 - num)
                    (adjacent ?x1 - xpos ?y1 - ypos ?x2 - xpos ?y2 - ypos)
                    (right ?x1 ?x2 - xpos)
                    (left ?x1 ?x2 - xpos)
                    (up ?y1 ?y2 - ypos)
                    (below ?y1 ?y2 - ypos)
                    (lit ?x - xpos ?y - ypos)
                    (black ?x1 - xpos ?y1 - ypos)
                    (surrounded ?x1 - xpos ?y1 - ypos ?n - num)
    )
    
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


