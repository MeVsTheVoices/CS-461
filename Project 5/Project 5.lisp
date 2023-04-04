(defun di(m n)
    (cond
        ((null n) nil)
        (t (cons (list m (car n))
                 (di m (cdr n))))))

(defun cartesian (m n)
    (cond
        ((null m) nil)
        (t (append (di (car m) n)
            (cartesian (cdr m) n)))
    )
)

(defun range (n)
    (cond
        ((< n 0) nil)
        ((equal n 0) (cons n (range (- n 1))))
        (t (cons n (range (- n 1))))
    )
)

(defun cartesian-ranges (a b)
    (cartesian (range a) (range b))
)

(defun illegal-transition (a b)
    (cond 
        ((> b a) t)
        ((< (+ a b) 1) t)
        ((> (+ a b) 2) t)
        (t nil)
    )
)

(defun find-transition (was is)
    `(,(- (car was) (car is)) ,(- (cadr was) (cadr is)))
)

(defun if-is-illegal-transition (was is)
    (let ((transition (find-transition was is)))
        (cond
            ((illegal-transition (car transition) (cadr transition))
                t)
            ((equal (caddr was) (caddr is))
                t)
        )
    )
)

(defun if-is-illegal-state (is)
    (let (
          (missionaries (car is))
            (cannibals (cadr is))
            )
        (cond
            ((> cannibals missionaries) t)
            ((or (> cannibals 3) (> missionaries 3)) t)
            ((or (< cannibals 0) (< missionaries 0)) t)
            (t nil)
    ))
)

(defun generate-cartesian-states (node tag)
    (map 'list (lambda (x) (append x (cons tag nil))) (cartesian-ranges (car node) (cadr node)))
)

(defun generate-legal-cartesian-states (node tag)
    (let ((generated-states (generate-cartesian-states node tag)))
        (delete-if #'if-is-illegal-state generated-states)
        (delete-if (lambda (x) (if-is-illegal-transition node x)) generated-states)

    )
)
