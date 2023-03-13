(defun find_opposite_bank (list)
    (list (- 3 (car list)) (- 3 (cadr list)) (caddr list))
)

(defun move_left_to_right_accumulator(node accumulator)
    (cond 
        ((> (car node) 0)
            (move_left_to_right_accumulator
                `(,(- (car node) 1) ,(cadr node) ,(caddr node))
                (cons node accumulator)
            ))
        ((> (cadr node) 0)
            (move_left_to_right_accumulator
                `(,(car node) ,(- (cadr node) 1) ,(caddr node))
                (cons node accumulator)
            ))
        (t
            accumulator)
    )
)

(defun move_left_to_right (node)
    (move_left_to_right_accumulator node ())
)

(defun do_actions (node)
    (if (equal (caddr node) #\l)
        (princ (move_left_to_right node))
    )
    (if (equal (caddr node) #\r)
        (princ (move_left_to_right (find_opposite_bank node)))
    )
)

