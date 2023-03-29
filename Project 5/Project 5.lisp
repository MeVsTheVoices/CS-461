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

