;return the side opposite of that a boat is on
(defun swap-side (node)
    (case (caddr node) 
        (#\l #\r)
        (#\r #\l) )
)


(defun di(m n)
    (cond
        ((null n) nil)
        (t (cons (list m (car n))
                 (di m (cdr n))))))

;used together with di to generate every possible combination
(defun cartesian (m n)
    (cond
        ((null m) nil)
        (t (append (di (car m) n)
            (cartesian (cdr m) n)))
    )
)

;does the cartesian product of 0 to n
(defun range (n)
    (cond
        ((< n 0) nil)
        ((equal n 0) (cons n (range (- n 1))))
        (t (cons n (range (- n 1))))
    )
)

;does the cartesian product of 0 to a and 0 to b
(defun cartesian-ranges (a b)
    (cartesian (range a) (range b))
)

;return true only if the transition is illegal
; (missionaries, cannibals)
(defun illegal-transition (a b)
    (cond 
        ((and (equal a 1) (equal b 1)) nil)
        ((and (equal a 0) (equal b 1)) nil)
        ((and (equal a 1) (equal b 0)) nil)
        (t t)
    )
)

;find how many people changed sides
(defun find-transition (was is)
    `(,(abs (- (car was) (car is))) ,(abs (- (cadr was) (cadr is))))
)

;again, only allow legal transitions
(defun if-is-illegal-transition (was is)
    (let ((transition (find-transition was is)))
        (cond
            ((and (equal (car transition) 1) (equal (cadr transition) 1)) nil)
            ((and (equal (car transition) 0) (equal (cadr transition) 1)) nil)
            ((and (equal (car transition) 1) (equal (cadr transition) 0)) nil)
            ((and (equal (car transition) 2) (equal (cadr transition) 0)) nil)
            ((and (equal (car transition) 0) (equal (cadr transition) 2)) nil)
            (t t)
        )
    )
)

;check states to confirm nobody gets eaten
(defun if-is-illegal-state (is)
    (let (
          (missionaries (car is))
            (cannibals (cadr is))
            )
        (cond
            ((> cannibals missionaries)
                (cond
                    ((equal missionaries 0) nil)
                    (t t)
                ))
            ((or (> cannibals 3) (> missionaries 3)) t)
            ((or (< cannibals 0) (< missionaries 0)) t)
            (t nil)
    ))
)

;generate all possible states from a given state
;change the side of the boat to tag
(defun generate-cartesian-states (node tag)
    (map 'list (lambda (x) (append x (cons tag nil))) (cartesian-ranges (car node) (cadr node)))
)

;generate all possible states from a given state
(defun generate-legal-cartesian-states (node)
    ;generate possibilites for opposite side if that's where the boat is
    (if (equal (caddr node) #\r)
        (setq generated-states
                (generate-cartesian-states 
                    `(,(- 3 (car node)) ,(- 3 (cadr node)) ,(caddr node)) (swap-side node)))
        (setq generated-states
                (generate-cartesian-states node (swap-side node)))
    )
    ;because we generated the possibilities for the opposite side, we need to
    ;flip the values back to the original side
    (if (equal (caddr node) #\r)
        (setf generated-states (map 'list (lambda (x) (list (- 3 (car x)) (- 3 (cadr x)) (caddr x))) generated-states))
        (setf generated-states generated-states)
    )
    ;remove illegal states
    (remove-if (lambda (x)
        (let (
            (inverse (list (- 3 (car x)) (- 3 (cadr x)) (caddr x)))
            (opposite-node `(,(abs (- 3 (car node))) ,(- 3 (cadr node)) ,(caddr node)))
            )
            (cond
                ((if-is-illegal-state x) t)
                ((if-is-illegal-state inverse) t)
                ((if-is-illegal-transition node x) t)
                ((and (equal
                        (car node) (car x))
                        (equal
                        (cadr node) (cadr x)) t))
            )
        )
    ) generated-states)
)

;attempts to minimize the distance between the current node and the goal
(defun closer-to (could-be-a could-be-b goal)
    (let (
        (a (+ (abs (- (car goal) (car could-be-a))) (abs (- (cadr goal) (cadr could-be-a)))))
        (b (+ (abs (- (car goal) (car could-be-b))) (abs (- (cadr goal) (cadr could-be-b)))))
        )
        (cond
            ((< a b) could-be-a)
            (t could-be-b)
        )
    )
)

;refractoring to two nexted functions instead of a looping function
;here we're keeping track of where we've been and what moves we've made
(defun depth-first-search (start goal been moves)
    (cond
        ((equal start goal) (reverse (cons start been)))
        (t (try-set start goal been (generate-legal-cartesian-states start) moves))
    )
)

;here we're trying to find a path to the goal
;depth-first-search generates the possibilities and this 
;function tries them
(defun try-set (start goal been moves-to moves)
    (cond 
    ;3 cases, no child, already seen the node before,
    ;or we have a valid node and should start trying to this path
        ((null moves-to) nil)
        ((member start been :test #'equal) nil)
        ;as per DFS we don't add anything to order the nodes
        (t (let ((child (car moves-to)))
            (if child
                (or (depth-first-search (car moves-to)
                                        goal
                                        (cons start been)
                                        moves)
                    (try-set start goal been (cdr moves-to) moves))
                (try-set start goal been (cdr moves-to) moves))))))