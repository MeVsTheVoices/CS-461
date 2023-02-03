; (load "Users/Feast/Desktop/Portacle/portacle/projects/CS-461/Project 2/main.lisp")

;given a radius return a circumference
(defun circle (radius) "return circumference given radius" (* radius pi 2))

;convert celcius in to farenheit
(defun temp-change (celcius) "convert from given celcius to farenheit" 
    (+ (* celcius (/ 9 5)) 32)
)

;use evenp as a predicate to determine evenness
(defun front-or-back (a_list) "is length of list given is odd, return head, otherwise, return tail" 
    (if (evenp (length a_list)) (car (reverse a_list)) (car a_list))
)

;create c instances of m, where n is an atom; returns a list of c m's
(defun create-list (m c) "return c copies of m in sequence" 
    (create-list-inner (cons m nil) m c)
)
;my first recursive function in LISP! Build the list backwards
(defun create-list-inner (m n c) "return c copies of m in sequence"
    (if (> c 0) (create-list-inner (cons n m) n (- c 1)) m)
)

;three cases, branch to a function based on type
(defun item-convert (i) "returns different results based of parameter type"
    (cond
        ((numberp i) (circle i))
        ((atom i) (create-list i 4))
        ((listp i) (front-or-back i)))
)
