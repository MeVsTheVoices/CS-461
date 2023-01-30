;(setq x '(a b c d))
;(setq y '(1 2 3 4))

(setq a '(a b c d))
(setq b '(1 2 3 4))

; a) (d c b a)

(print "a) (d c b a)")
(print '(cons (car (cdr (cdr (cdr a)))) (cons (car (cdr (cdr a))) (cons (car (cdr a)) (cons (car a) nil)))))
(print (cons (car (cdr (cdr (cdr a)))) (cons (car (cdr (cdr a))) (cons (car (cdr a)) (cons (car a) nil)))))

; b) (4 c (b 2))

(print "b) (4 c (b 2))")
(print '(cons 4 (cons (car (cdr (cdr a))) (cons (cons (car (cdr a)) (cons (car (cdr b)) nil)) nil))))
(print (cons 4 (cons (car (cdr (cdr a))) (cons (cons (car (cdr a)) (cons (car (cdr b)) nil)) nil))))

; c) ((a b c d) . 1)

(print "c) ((a b c d) . 1)")
(print (cons (cons (car a) (cons (car (cdr a)) (cons (car (cdr (cdr a))) (cons (car (cdr (cdr (cdr a)))) nil)))) (car b)))
(print '(cons (cons (car a) (cons (car (cdr a)) (cons (car (cdr (cdr a))) (cons (car (cdr (cdr (cdr a)))) nil)))) (car b)))

; d) (((a c) (1 2)) . a)

(print "(((a c) (1 2)) . a)")
(print '(cons (cons (cons (cons (car a) (cons (car (cdr (cdr a))) nil)) nil) (cons (cons (car b) (cons (car (cdr b)) nil)) nil)) (car a)))
(print (cons (cons (cons (cons (car a) (cons (car (cdr (cdr a))) nil)) nil) (cons (cons (car b) (cons (car (cdr b)) nil)) nil)) (car a)))

; e) ((a 1) (b 2) (c 3) (d  4))

(print "((a 1) (b 2) (c 3) (d  4))")
(print '(cons (cons (car a) (cons (car b) nil)) (cons (cons (car (cdr a)) (cons (car (cdr b)) nil)) (cons (cons (car (cdr (cdr a))) (cons (car (cdr (cdr b))) nil)) (cons (cons (car (cdr (cdr (cdr a)))) (cons (car (cdr (cdr (cdr b)))) nil)) nil)))))
(print (cons (cons (car a) (cons (car b) nil)) (cons (cons (car (cdr a)) (cons (car (cdr b)) nil)) (cons (cons (car (cdr (cdr a))) (cons (car (cdr (cdr b))) nil)) (cons (cons (car (cdr (cdr (cdr a)))) (cons (car (cdr (cdr (cdr b)))) nil)) nil)))))