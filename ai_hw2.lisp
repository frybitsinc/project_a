;1. count-all-atom
(defun count-all-atom (list)
	(if (null (car list))
		1 	
		(+ (count-all-atom (car list)) (count-all-atom (cdr list)))
	)
)


(print "======================")
(print "#1. count-all-atom")
(print (count-all-atom '((a b) c () ((d(e))))))
(print (count-all-atom '(()())))
(print (count-all-atom '((()))))
(print (count-all-atom '()))
;2. remove-all2
;3. reverse-all
;4. depth
;5. flatten
;6. remove-left-most
;7. find-subst
;8. subst-count
;9. (select db test)
;10. (reflect slist list)
;11. (echo table list)
