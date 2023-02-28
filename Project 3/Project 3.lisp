(defun count-atoms (l)
	(if 
		(atom l) 1
		(+  (count-atoms (car l))
		    (count-atoms (cdr l)))))

(defun member-any (l m)
	(cond
		((atom l) (when (equalp m l) m))
		((null l) nil)
		((list l)
			(or (member-any (car l) m) (member-any (cdr l) m)))))
