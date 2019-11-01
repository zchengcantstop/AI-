(define (domain puzzle)
(:requirements :strips :equality :typing
	       )	   
(:predicates (at ?x - num ?y - loc)
              (adj ?x - loc ?y - loc))

(:action slide
	:parameters (?x - num ?y - loc ?z - loc)
	:precondition(and (at ?x ?y) (or (adj ?z ?y) (adj ?y ?z )) (at T0 ?z))
	:effect(and (at ?x ?z) (at T0 ?y) (not (at ?x ?y)) (not (at T0 ?z)))
 )
)

