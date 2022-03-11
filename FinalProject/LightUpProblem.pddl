(define (problem LightUp1)
	(:domain LightUp)
	(:objects x0 x1 x2 x3 x4 - xpos
		  y0 y1 y2 y3 y4 - ypos
		  b1 b2 b3 b4 - num)

	(:init 	(black x2 y1) (black x3 y2) (black x2 y3) (black x4 y4) (black x0 y0)

		(right x1 x0) (right x2 x0) (right x3 x0) (right x4 x0)
		(right x2 x1) (right x3 x1) (right x4 x1) 
		(right x3 x2) (right x4 x2)
		(right x4 x3)


		(below y1 y0) (below y2 y0) (below y3 y0) (below y4 y0)
		(below y2 y1) (below y3 y1) (below y4 y1)
		(below y3 y2) (below y4 y2)
		(below y4 y3)


		(left x0 x1) (left x0 x2) (left x0 x3) (left x0 x4)
		(left x1 x2) (left x1 x3) (left x1 x4)
		(left x2 x3) (left x2 x4)
		(left x3 x4)

	
		(above y0 y1) (above y0 y2) (above y0 y3) (above y0 y4)
		(above y1 y2) (above y1 y3) (above y1 y4)
		(above y2 y3) (above y2 y4)
		(above y3 y4)
	)
		

	(:goal	(and 
		(lit x1 y0) (lit x2 y0) (lit x3 y0) (lit x4 y0)
		(lit x0 y1) (lit x1 y1) (lit x3 y1) (lit x4 y1)
		(lit x0 y2) (lit x1 y2) (lit x2 y2) (lit x4 y2) 
		(lit x0 y3) (lit x1 y3) (lit x3 y3) (lit x4 y3) 
		(lit x0 y4) (lit x1 y4) (lit x2 y4) (lit x3 y4))
	)
)


