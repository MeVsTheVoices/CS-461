
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
    ;remove if less than 0
    (delete-if (lambda (x) 
            (or (< (car x) 0)
                (< (cadr x) 0))) all_nodes)
    ;remove if moved more than 2 total
    (delete-if (lambda (x)
            (> (+ (- (car node) (car x)) (- (cadr node) (cadr x))) 2))
            all_nodes)
    ;too many cannibals
    (delete-if (lambda (x)
            (> (cadr node) (car node)))
            all_nodes)
    all_nodes
)

;run the given state against a set of predicates
;will only return true for sensible states
(defun is_valid_state (node) 
    (cond  
        ;boat is either on the left or the right
        ((not (or (equal (caddr node) #\l) (equal (caddr node) #\r))) 
            nil)
        ;we have between 3 and 0 missionaries on the left side
        ((or (< (car node) 0) (> (car node) 3))
            nil)
        ;we have between 3 and 0 cannibals on the left side
        ((or (< (cadr node) 0) (> (cadr node) 3))
            nil)
        (t t)
    )
)

;swaps the side of the boat in the list of states given
(defun swap_sides_list (states)
    ;apply swap_sides to the third element of every element
    (mapcar (lambda (x)
                `(,(car x) ,(cadr x) ,(swap_sides (caddr x)))
            )
        states
    )
)

;check for a valid state and then generate all possible
;child states according to the missionaries and
;cannibals problem
(defun do_actions (node)
    (if (is_valid_state node)
        (case (caddr node) 
            ;in both cases we move the boat to the other side
            ;in all the states that were generated
            ((#\l)
                ;remove the initial point
                (remove-if (lambda (x)
                            (and (equal (car x) (car node))
                                 (equal (cadr x) (cadr node))))
                    ;calculate and swap the boats side
                    (swap_sides_list (move_all_and_check node ()))))
            ((#\r)
                ;we use inverted values
                (let ((swapped (find_opposite_bank node)))
                    ;remove the initial point having calculated
                    ;for the other side
                    (remove-if (lambda (x)
                            (and (equal (car x) (car swapped))
                                 (equal (cadr x) (cadr swapped)))) 
                    ;calculate from the inverted number and flip the boat
                    (swap_sides_list (move_all_and_check (find_opposite_bank node) ())))))
        )
        ;if the state provided wasn't valid, print out and error
        ;and take no further action
        (format t "~S is not a valid state~%" node)
    )
)

;passthrough to conform to the specifications
(defun mac-next (node)
    (do_actions node)
)
