(define (domain blocks)
  (:requirements :strips :typing :equality
				 :universal-preconditions
				 :conditional-effects)
  ;(:types physob)
  (:predicates
			(ontable ?x - physob)
			(clear ?x - physob)
			(on ?x ?y - physob) )
  (:action move
			:parameters (?x ?y - physob)
			:precondition(and(clear ?x) (clear ?y))
			:effect (and (on ?x ?y) (not (clear ?y)) (not (ontable ?x))
			              (forall (?z -physob)
								(when (on ?x ?z)
									  (and (clear ?z) (not (on ?x ?z))))
								) 
						  )
						  )
  (:action moveToTable
			:parameters (?x - physob)
			:precondition(and(not (ontable ?x)) (clear ?x))
			:effect
			(and (ontable ?x)
				(forall (?y - physob)
					(when (on ?x ?y)
					       (and (not(on ?x ?y)) (clear ?y)))
				))
			)
)