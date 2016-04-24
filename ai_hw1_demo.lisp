;all solved and submitted
;1. LAST-ITEM
(defun last-item (list) 
	(if (null list) 
		nil 
		(if(= (length list) 1) 
			(car list)
			(last-item (cdr list))
		) 
	)
)
(print "------------------------" )
(print "#1. LAST-ITEM")
(print (last-item '(1 2 3 4) ) )
(print (last-item '(a b (c d))))
(print (last-item '(a)))
(print (last-item '((a))))

;2. REMOVE-1ST
(defun remove-1st (x list)
	(if (null list)
		nil
		(if(equal x (car list))
			(cdr list)
			(cons (car list) (remove-1st x (cdr list)) )
		)
	)
)
(print "------------------------" )
(print "#2. REMOVE-1ST")
(print (remove-1st 'a '(b a n a n a) )) 
(print (remove-1st 'a '(b (a n) a n a ) )) 
(print (remove-1st '(1 2) '(1 2 (1 2) 3) )) 
(print (remove-1st 'cat '(dog fox hen) ))  

;3. REMOVE-2ND
(defun remove-2nd (x list)
	(if (null list)
		nil
		(if (equal x (car list))
			(cons (car list) (remove-1st x (cdr list)))
			(cons (car list)(remove-2nd x (cdr list)) )
		)		
	)
)
(print "------------------------" )
(print "#3. REMOVE-2ND")
(print (remove-2nd 'a '(b a n a n a) )) 
(print (remove-2nd 'a '(b (a n) a n a ) )) 
(print (remove-2nd '(1 2) '(1 2 (1 2) 3) )) 

;4. REMOVE-LAST
(defun remove-last (x list)
	(reverse (remove-1st x (reverse list)))
)
(print "------------------------" )
(print "#4. REMOVE-LAST")
(print (remove-last 'a '(b a n a n a s) )) 
(print (remove-last 'a '(b (a n) a n a ) )) 
(print (remove-last '(1 2) '(1 2 (1 2) 3) )) 

;5. REMOVE-ALL1
(defun remove-all1 (x list) 
	(if (null list)	
		nil
		(if (equal x (car list))
			(remove-all1 x (cdr list))
			(cons (car list)(remove-all1 x (cdr list)) )
		)
	)
)
(print "------------------------" )
(print "#5. REMOVE-ALL1")
(print (remove-all1 'a '(b a n a n a s) )) 
(print (remove-all1 'a '(b (a n) a n a) )) 
(print (remove-all1 '(1 2) '(1 2 (1 2) 3) ))  

;6. SUBST-1ST
(defun subst-1st (x2 x1 list) 
	(if(null list) 
		nil
		(if(equal x1 (car list))
			(cons x2 (cdr list))
			(cons (car list) (subst-1st x2 x1 (cdr list)) )	
		)	
	)
)
(print "------------------------" )
(print "#6. SUBST-1ST")
(print (subst-1st 'dog 'cat '(my cat is cute) ) ) 
(print (subst-1st 'b 'a '(c a b a c) )) 
(print (subst-1st '(0) '(*) '((*)(*)(0)) )  ) 

;7. SUBST-ALL
(defun subst-all (x2 x1 list) 
	(if(null list) 
		nil
		(if(equal x1 (car list))
			(cons x2 (subst-all x2 x1 (cdr list))  )
			(cons (car list) (subst-all x2 x1 (cdr list)) )	
		)	
	)
)
(print "------------------------" )
(print "#7. SUBST-ALL")
(print (subst-all 'dog 'cat '(my cat is cute) ) ) 
(print (subst-all 'b 'a '(c a b a c)) ) 
(print (subst-all '(0) '(*) '((*)(*)(0)) )  ) 

;8. PUT-AGE
(defun put-age (x y list)
	(cons (cons x (cons y nil)) list)
)
(print "------------------------" )
(print "#8. PUT-AGE")
(print (put-age 'tom 20 '((mary 19)(joe 25))))

;9. GET-AGE
(defun get-age (name list)
	(if (equal name (caar list))      
		(cadar list)
		(get-age name (cdr list))
	)
)
(print "------------------------" )
(print "#9. GET-AGE")
(print (get-age 'joe '((tom 20)(mary 19)(joe 25)) ))

;10. MERGE
(defun my-merge (list1 list2)
	(cond
		( (null list1) list2 )	
		( (null list2) list1 )
		(t 
			(if (<= (car list1) (car list2))        
				(cons (car list1) (my-merge (cdr list1) list2 ) )  
				(cons (car list2) (my-merge list1 (cdr list2) ) )
			)
		)
	)
)
(print "------------------------" )
(print "#10. MERGE")
(print (my-merge '(1 3 4 7) '(2 4 5)))
