;1. count-all-atom
(defun count-all-atom (list)
	(cond
		((atom list) 1)
		(t
			(+ (count-all-atom (car list)) 
			   (count-all-atom (cdr list)))
		)
	)
)
(print "======================")
(print "#1. count-all-atom")
(print (count-all-atom '((a b) c () ((d(e))))))
(print (count-all-atom '(()())))
(print (count-all-atom '((()))))
(print (count-all-atom ()))

;2. remove-all2
(defun remove-all2 (x list)
	(cond 	((atom list) list )
		((equal x (car list)) (remove-all2 x (cdr list)) )
		(t 
			(cons  (remove-all2 x (car list)) (remove-all2 x (cdr list))  )
		)
	)
)
(print "======================")
(print "#2. remove-all2")
(print (remove-all2 'a '(b (a n) a n a) ))
(print (remove-all2 'a '((a b (c a))(b (a c) a))))
(print (remove-all2 '(a b) '(a (a b)( (c (a b)) b))))
;3. reverse-all
(defun reverse-all (list)
	(cond	((null list) nil)
		((listp (car list)) (append (reverse-all (cdr list)) (list (reverse-all (car list) ))  )  )
		(t
			(append (reverse-all (cdr list)) (list (car list)) )
		)
	)
)
(print "======================")
(print "#3. reverse-all")
(print (reverse-all '((1 2) (3 4) 5)))
(print (reverse-all '(a (b c) (d (e f)))))
;4. depth
(defun depth (list)
	(if (atom list)
		0
		(+ 1 (reduce #'max (mapcar #'depth list)))
	)
)
(print "======================")
(print "#4. depth")
(print (depth ()))
(print (depth '(a b c)))
(print (depth '(a (b c))))
(print (depth '((a b) c (d ((f))))))
;5. flatten
(defun flatten (list)
	(if (null list)  
		nil
		(if (atom (car list))
			(cons (car list) (flatten (cdr list)) )
			(append (flatten (car list) )  (flatten (cdr list)) )
		)
	)
)
(print "======================")
(print "#5. flatten")
(print (flatten '((a b) c (d ((f))))))
;6. remove-left-most
(defun remove-left-most (x list)
	(cond	((atom list) list)
		((equal x (car list)) (cdr list)  )
		(t
			(cons (remove-left-most x (car list)) (remove-left-most x (cdr list)) )
		)
	)	
)

(print "======================")
(print "#6. remove-left-most")
(print (remove-left-most 'b '(a (b c) (c (b a)))))
(print (remove-left-most '(c d) '((a (b c)) ((c d) e))))
;7. find-subst
(defun find-subst (x y)
	(if (null x)
		nil
		(let ((pos (search x y)))
			(when pos (subseq y pos)))))
(print "======================")
(print "#7. find-subst")
(print (find-subst '(b a b o) '(b b a a b b a b o o b b) ))
;8. subst-count
(defun list-front(x list)
	(if (= x 0)
		nil
		(cons (car list)(list-front (- x 1) (cdr list) ))
	)
)
(defun subst-count (x list)
	(if (> (length x)(length list) )
		0
		(if (equal x(list-front (length x)list ))
			(+ 1 (subst-count x (cdr list)))
			(subst-count x (cdr list))
		)
	)
)

(print "======================")
(print "#8. subst-count")
(print (subst-count '(b a b) '(b b a b a b b a a b) ))
;9. (select db test)
(defun select (db f) 
	(if(null db) 
		nil
		(if (funcall f (cadar db) )      
			(cons (caar db) (select (cdr db) f ) )
			(select (cdr db) f))))
(setq db '((tom 22)(jack 25) (joe 44) (judy 10)))
(print "======================")
(print "#9. (select db test)")
(print db)
(print (select db #' (lambda (n) (> n 23) )))

;10. (reflect slist list)
(print "======================")
(print "#10. (reflect slist list)")
(defun reflect-atom (x list)
	(if (null list)
		x
		(if (eq x (caar list))
			(cadar list)
			(reflect-atom x (cdr list))
		)
	)
)
(defun reflect (table list)
	(if(null list)
		nil
		(append (list (reflect-atom (car list) table))(reflect table (cdr list))  )
	)
)
(setq table '((i u)(you me) ))
(print (reflect '((I U)(U me))  '(I love U) )  )
(print (reflect '((ugly handsome) (is was)(fool genius) ) '(Tom thinks he is a fool)) )
;11. (echo table list)
(print "======================")
(print "#11. (echo table list)")
(defun echo (table list)
	(if (null list)
		nil
		(append '(you mean) (reflect table list) '(?) ) 
	)
)
(print (echo table '(i love you)))
(print (echo table '(i think i hate you)))
