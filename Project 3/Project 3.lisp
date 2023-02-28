;returns the number of atoms in a possibly nested list
(defun count-atoms (l)
	(if l
		(+ (if (atom (car l)) 1
		     (count-atoms (car l)))
		   (count-atoms (cdr l))
		 ) 0
	)
)

;takes arguments in form, list, element to be searched for
;returns true if found, false if not
(defun member-any (l m)
	(cond
		((atom l) (when (equalp m l) m))
		((null l) nil)
		((list l)
			(or (member-any (car l) m) (member-any (cdr l) m)))))

;returns an integer specifying the greatest depth at which an element was found
(defun find-depth (l)
	(cond
		((null l) 0)
		((atom l) 0)
		((list l)
			(max (+ 1 (find-depth (car l))) (+ 0 (find-depth (cdr l)))))
	)
)

;unnests all structures within a given list and returns it
(defun flatten (l)
	(if
		(atom l) (list l)
		(append (flatten (car l)) (if (cdr l) (flatten (cdr l))))))
