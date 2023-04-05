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
        ((and (equal a 1) (equal b 1)) nil)
        ((and (equal a 0) (equal b 1)) nil)
        ((and (equal a 1) (equal b 0)) nil)
        (t t)
    )
)

(defun find-transition (was is)
    `(,(abs (- (car was) (car is))) ,(abs (- (cadr was) (cadr is))))
)

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

(defun generate-cartesian-states (node tag)
    (map 'list (lambda (x) (append x (cons tag nil))) (cartesian-ranges (car node) (cadr node)))
)

(defun generate-legal-cartesian-states (node)
    (if (equal (caddr node) #\r)
        (setq generated-states
                (generate-cartesian-states 
                    `(,(- 3 (car node)) ,(- 3 (cadr node)) ,(caddr node)) (swap-side node)))
        (setq generated-states
                (generate-cartesian-states node (swap-side node)))
    )
    (print node)
    (print generated-states)
    (remove-if (lambda (x)
        (let (
            (inverse (list (- 3 (car x)) (- 3 (cadr x)) (caddr x)))
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

(defun keep-trying (node goal)
    (let ((generated-states (generate-legal-cartesian-states node)))
        (print node)
        (print generated-states)
        (cond
            ((null generated-states) nil)
            ((or
                (member `(,(car goal) ,(cadr goal), #\l) generated-states)
                (member `(,(car goal) ,(cadr goal), #\l) generated-states))
                goal)
            (t (keep-trying (car generated-states) goal))
        )
    )
)