;(look)			: describe game world from current location. 
;(walk (direction)) 	: move to some directions to change current location. 
;(pickup (object)) 	: pickup objects. 
;(inventory) 		: open inventory and show all objects player picked up. 
;
;get princess name 	"which princess are you?"
;introduction		"you are now in ice kingdom kidnapped by ice king..."
;			"call finn and jake to rescue you...find item and use it to escape.."
;			"unless you'll be married to ice king...stay determined..."
(defparameter *nodes* '(
	(living-room 	(you are in the living room. a wizard the ice king is snoring loudly in the couch. )) 
	(garden 	(you are in a beautiful garden. there is a well frozen in front of you. ))
	(attic 		(you are in the attic. there is a giant welding torch and gunter in the corner. ))))
(defun describe-location (location nodes) 
	(cadr (assoc location nodes)))
;(print (describe-location 'living-room *nodes*))
;(print (describe-location 'garden *nodes*))
;(print (describe-location 'attic *nodes*))
(defparameter *edges* '(
	(living-room 	(garden west door) 
			(attic upstairs ladder))
	(garden 	(living-room east door))
	(attic 		(living-room downstairs ladder))))
(defun describe-path (edge)
	`(there is a ,(caddr edge) going ,(cadr edge) from here.))
;(print (describe-path '(garden west door)))
(defun describe-paths (location edges)
	(apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))
;(print (describe-paths 'living-room *edges*))
;(print (describe-paths 'garden *edges*))
;(print (describe-paths 'attic *edges*))
(defparameter *objects* '(whiskey bucket frog chain))
(defparameter *object-locations* '(
	(whiskey living-room) 
	(bucket living-room) 
	(chain garden) 
	(frog garden)))
(defun objects-at (loc objs obj-locs)
	(labels ((at-loc-p (obj)
		(eq (cadr (assoc obj obj-locs)) loc)))
	(remove-if-not #'at-loc-p objs)))
;(print (object-at 'living-room *objects* *object-locations*))
;(print (object-at 'garden *objects* *object-locations*))
;(print (object-at 'attic *objects* *object-locations*))
(defun describe-objects (loc objs obj-loc)
	(labels ((describe-obj (obj)
		`(you see a ,obj on the floor. )))
	(apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))
;(print (describe-objects 'living-room *objects* *object-locations*))
;(print (describe-objects 'garden *objects* *object-locations*))
;(print (describe-objects 'attic *objects* *object-locations*))
(defun look ()
	(append (describe-location *location* *nodes*)
		(describe-paths *location* *edges*)
		(describe-objects *location* *objects* *object-locations*)))
(defparameter *location* 'living-room)
;(defparameter *location* 'garden)
;(defparameter *location* 'attic)
;(print (look))
(defun walk (direction)
	(let ((next (find direction
			(cdr (assoc *location* *edges*))
			:key #'cadr)))
	(if next
		(progn (setf *location* (car next))
			(look))
		'(you cannot go that way.))))
;(print (walk 'west))
(defun pickup (object)
	(cond ((member object
			(objects-at *location* *objects* *object-locations*))
		(push (list object 'body) *object-locations*)
		`(you are now carrying the ,object))
		(t '(you cannot get that.))))
;(print (walk 'east))
;(print (pickup 'whiskey))
(defun inventory ()
	(cons 'items- (objects-at 'body *objects* *object-locations*)))
;(print (inventory))
