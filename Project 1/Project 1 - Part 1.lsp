;a) (he is dead jim) 

(print '(car (reverse '(he is dead jim))))
(print (car (reverse '(he is dead jim))))

;b) (captain (((jim) kirk))) 

(print '(car (car (car (car (cdr '(captain (((jim) kirk)))))))))
(print (car (car (car (car (cdr '(captain (((jim) kirk)))))))))

;c) (((((spock) asked) jim) if) he was all right) 

(print '(car (cdr (car (car '(((((spock) asked) jim) if) he was all right))))))
(print (car (cdr (car (car '(((((spock) asked) jim) if) he was all right))))))

;d) (after (looking at the (lizard man) ((((jim))) asked for warp 9))) 

(print '(car (car (car (car (car (nthcdr 4 (car (cdr '(after (looking at the (lizard man) ((((jim))) asked for warp 9))))))))))))
(print (car (car (car (car (car (nthcdr 4 (car (cdr '(after (looking at the (lizard man) ((((jim))) asked for warp 9))))))))))))

;e) (append (star (trek)) (jim))

(print '(car (cdr (cdr (eval '(append '(star (trek)) '(jim)))))))
(print (car (cdr (cdr (eval '(append '(star (trek)) '(jim)))))))