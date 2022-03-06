;Problem file for Towers of Hanoi

(define (problem Towers1)
	(:domain Towers)
	(:objects pegA pegB pegC disk1 disk2 disk3)
	
	(:init 
		(smaller disk3 disk2) (smaller disk2 disk1) (smaller disk3 disk1)
		(smaller disk1 pegA) (smaller disk2 pegA) (smaller disk3 pegA)
		(smaller disk1 pegB) (smaller disk2 pegB) (smaller disk3 pegB)
		(smaller disk1 pegC) (smaller disk2 pegC) (smaller disk3 pegC)
		(clear disk3) (clear pegB) (clear pegC)
		(on disk3 disk2) (on disk2 disk1) (on disk1 pegA))


	(:goal (and (on disk1 pegC) (on disk2 disk1) (on disk3 disk2))))
		
	
