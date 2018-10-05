;; Domain definition
(define (domain honey-domain)

  ;; Predicates: Properties of objects that we are interested in (boolean)
  (:predicates
    (POSITION ?x) ; True if x is a position
    (ARM ?x) ; True if x is an arm
    (OBJECT ?x) ; True if x is an object
    (BEE-HOUSE ?x) ; True if x is a bee-house
    (HONEY-POT ?x) ; True if x is a honey pot
    (COSTUME ?x) ; True if x is a costume
    (person-at ?x) ; True if the person is at x
    (object-at ?x ?y) ; True if x is an object (bee-house, honey-pot or costume), y is a position and x is in y
    (free ?x) ; True if x is an arm and there is NO honey pot in it
    (hold ?x ?y) ; True if x is an arm, y is a honey pot and x holds y
    (wearing ?x) ; True if x is a costume and the person is wearing it
    (empty ?x) ; True if x is a honey pot and it is empty
    (has-honey ?x) ; True if the bee-house x has honey
  )

  ;; Actions: Ways of changing the state of the world
  ; The person can move from position x to position y
  ; Parameters:
  ; - x: the position from which the person starts moving
  ; - y: the position to which she moves
  (:action move
    :parameters (?x ?y)
    :precondition (and (person-at ?x) (POSITION ?x) (POSITION ?y) (not (person-at ?y)))
    :effect (and (person-at ?y) (not (person-at ?x)))
    ; WRITE HERE THE CODE FOR THIS ACTION
  )

  ; The person can take a costume x and put it on if she and the costume are both at position y
  ; Parameters:
  ; - x: the costume
  ; - y: the position where the person will put on the costume
  (:action wear-at
    :parameters (?x ?y)
    :precondition (and (COSTUME ?x) (POSITION ?y) (not (wearing ?x)) (object-at ?x ?y) (person-at ?y))
    :effect (and (wearing ?x) (not (object-at ?x ?y)))
    ; WRITE HERE THE CODE FOR THIS ACTION
  )

  ; The person can take off the costume x at position y
  ; Parameters:
  ; - x: the costume
  ; - y: the position where the costume will be taken off
  (:action take-off-at
    :parameters (?x ?y)
    :precondition (and (COSTUME ?x) (POSITION ?y) (wearing ?x) (person-at ?y))
    :effect (and (not (wearing ?x)) (object-at ?x ?y))
    ; WRITE HERE THE CODE FOR THIS ACTION
  )

  ; The person can collect all honey from bee house w to honey pot x if 
  ; there is honey in the bee house, the honey pot is empty, 
  ; the person is wearing costume y, has a free arm v, and 
  ; she, the bee house and the honey pot are in the same position z.
  ; - x: the honey pot
  ; - y: the costume
  ; - z: the position where the person collects the honey
  ; - w: the bee house
  ; - v: the arm
  (:action collect
    :parameters (?x ?y ?z ?w ?v)
    :precondition (and (COSTUME ?y) (HONEY-POT ?x) (ARM ?v) (POSITION ?z) (BEE-HOUSE ?w) (object-at ?x ?z) (empty ?x) (wearing ?y) (object-at ?w ?z) (free ?v) (has-honey ?w) (person-at ?z))
    :effect (and (not (empty ?x)) (not (has-honey ?w)))
    ; WRITE HERE THE CODE FOR THIS ACTION
  )

  ; The person can pick-up honey pot x with free arm y at position z
  ; - x: the honey pot
  ; - y: the arm
  ; - z: the position where the object is picked up
  (:action pick-up
    :parameters (?x ?y ?z)
    :precondition (and (free ?y) (person-at ?z) (object-at ?x ?z) (HONEY-POT ?x) (ARM ?y) (POSITION ?z))
    :effect (and (hold ?y ?x) (not (free ?y)) (not (object-at ?x ?z)))
    ; WRITE HERE THE CODE FOR THIS ACTION
  )

  ; The person can drop off honey pot x that she holds in arm y at position z
  ; - x: the honey pot
  ; - y: the arm
  ; - z: the position where the object is dropped off
  (:action drop-off
    :parameters (?x ?y ?z)
    :precondition (and (person-at ?z) (hold ?y ?x) (ARM ?y) (HONEY-POT ?x) (POSITION ?z))
    :effect (and (not (hold ?y ?x)) (object-at ?x ?z) (free ?y))
    ; WRITE HERE THE CODE FOR THIS ACTION
  )

)
