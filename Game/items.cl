(defvar items-sheet (make-sprite-sheet :file "Game/assets/items-sheet.png"))
(defvar player-sheet (make-sprite-sheet :file "Game/assets/chef-sheet.png"))
(defvar item-builders nil)
(defvar falling-items nil)

(defstruct (player (:include t-object
			     (x (round (- (/ *screen-width* 2) 32)))
			     (y 0)
			     (height (round (/ *screen-width* 5)))
			     (width (round (/ *screen-width* 5)))
			     ))
  (health 5)
  (points 0))
(defvar player (make-player))

(defstruct item
  x
  y
  (angle 0)
  (amount 100)
  cell)



(defmacro define-item (item amount cell)
  (let ((func-name (intern (string-upcase (concatenate 'string "make-" (symbol-name item))))))
    (push `',func-name item-builders)
    `(defstruct (,item (:include item (amount ,amount) (cell ,cell))))))

(defmacro defitem-cell (item cell)
  `(setf (item-cell ,item) ,cell))

(defmacro decrease-score (amount)
  `(decf score ,amount))
(defmacro increase-score (amount)
  `(incf score ,amount))

(defun spawn-item ()
  (push (funcall (eval (nth (random (length item-builders)) item-builders))) falling-items)
  (setf (item-x (car falling-items)) (random *screen-width*)
	(item-y (car falling-items)) 0))
