(define (problem Carving1)
	(:domain Carving)


	(:objects	left right - hand
			hokkaido muskat none - pumpkin
			dog cat bat - tool)


	(:init	(looking none) (empty left) (empty right)
		(available dog) (available cat) (available bat)
		(not (design muskat dog)) (not (design muskat cat)) (not (design muskat bat))
		(not (design hokkaido dog)) (not (design hokkaido cat)) (not (design hokkaido bat)))
		

	(:goal (and (design muskat dog) (design muskat cat) (design hokkaido bat))))
	
