
;utility function
;assumes 3 cannibals and 3 missionaries
;returns a state with the number of each on the opposite bank
;and the side of the boat left unchanged
(defun find_opposite_bank (list)
    (list (- 3 (car list)) (- 3 (cadr list)) (caddr list))
)

;utility function
;returns the same state with the boat
;on the opposite side
(defun swap_sides (side) 
    (cond
        ((equal side #\r) #\l) 
        ((equal side #\l) #\r)
        (t side)
    )
)

;generate every possible permuation by subtracting
;all combinations of 0, 1, 2 missionaries and
;0, 1, 2 cannibals
(defun move_all (node)
    (loop for a from 0 to 2 collect
        (let ((i_node `(,(- (car node) a) ,(cadr node) ,(caddr node))))
            (loop for b from 0 to 2 collect
                `(,(car i_node) ,(- (cadr i_node) b) ,(caddr i_node))))
    )
)

;apply some prediates to every possible permuation
;to maintain constistency with the problem
(defun move_all_and_check (node accumulator)
    ;remove one level of nesting
    (setq all_nodes (mapcan (lambda (x) x) (move_all node)))
    (delete-if (lambda (x) 
            (or (< (car x) 0)
                (< (cadr x) 0))) all_nodes)
    (delete-if (lambda (x)
            (> (+ (- (car node) (car x)) (- (cadr node) (cadr x))) 2))
            all_nodes)
    all_nodes
)

;all that changes based on the boat is that the
;opposite side is calculated, then those values used
;to calculate the state
(defun do_actions (node)
    (if (equal (caddr node) #\l)
        (princ (remove-duplicates (move_left_to_right node)))
    )
    (if (equal (caddr node) #\r)
        (princ (remove-duplicates (move_left_to_right (find_opposite_bank node))))
    )
)

