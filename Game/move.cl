(defun move-player ()
  (case moving
    (left (incf cell-accumulator 10)
	  (if (> (player-x player) (- 0 (/ 310 5)))
	      (decf (player-x player) 16))
	  (if (> cell-accumulator 10)
	      (progn (if (and (> (player-current-cell player) 3)
			      (< (player-current-cell player) 7))
			 (incf (player-current-cell player) 1)
			 (setf (player-current-cell player) 4))
		     (setf cell-accumulator 0))))
    (right (incf cell-accumulator 10)
	   (if (< (player-x player) (- *screen-width* (round (/ (player-width player) 2))))
	       (incf (player-x player) 16))
	   (if (> cell-accumulator 10)
	       (progn (if (< (player-current-cell player) 3)
			     (incf (player-current-cell player) 1)
			     (setf (player-current-cell player) 0))
			 (setf cell-accumulator 0))))))
(add-loop-function move-player level 'top)

(defun stop-moving ()
  (case moving
    (left (setf cell-accumulator 10)
	  (setf (player-current-cell player) 4)
	  (setf moving nil))
    (right (setf cell-accumulator 10)
	   (setf (player-current-cell player) 0)
	   (setf moving nil)))) 
