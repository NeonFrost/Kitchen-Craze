(defstruct (player (:include t-object
			     (x (round (- (/ *screen-width* 2) 32)))
			     (y 0)
			     (height (round (/ *screen-width* 5)))
			     (width (round (/ *screen-width* 5)))
			     ))
  (current-cell 0)
  (health 5)
  (points 0))
(defvar player (make-player))

(defstruct item
  x
  y
  (angle 0)
  (amount 100)
  cell)

(defvar items-sheet (make-sprite-sheet :file "Game/assets/items-sheet.png"))
(defvar player-sheet (make-sprite-sheet :file "Game/assets/chef-sheet.png"))
(defvar item-builders nil)
(defvar falling-items nil)

(defmacro define-item (item amount cell)
  `(defstruct (,item (:include item (amount ,amount) (cell ,cell)))))

(defmacro defitem-cell (item cell)
  `(setf (item-cell ,item) ,cell))

(defmacro decrease-score (amount)
  `(decf score ,amount))
(defmacro increase-score (amount)
  `(incf score ,amount))

(defun spawn-item ()
  (push (funcall (nth (random (length item-builders)) item-builders)) falling-items)
  (setf (item-x (car falling-items)) (random *screen-width*)
	(item-y (car falling-items)) 0))

(define-item carrot 50 1)
(push #'make-carrot item-builders)
(define-item pineapple 50 2)
(push #'make-pineapple item-builders)
(define-item potato 50 3)
(push #'make-potato item-builders)
(define-item bean 50 4)
(push #'make-bean item-builders)
(define-item bell-pepper 50 17)
(push #'make-bell-pepper item-builders)

(define-item eggplant 100 0)
(push #'make-eggplant item-builders)
(define-item can-of-beans 100 5)
(push #'make-can-of-beans item-builders)
(define-item broccoli 100 12)
(push #'make-broccoli item-builders)
(define-item onion 100 13)
(push #'make-onion item-builders)
(define-item garlic 100 14)
(push #'make-garlic item-builders)

(define-item flour 1000 6)
(push #'make-flour item-builders)
(define-item apple 1000 15)
(push #'make-apple item-builders)
(define-item orange 1000 10)
(push #'make-orange item-builders)

(define-item strawberry 5000 11)
(push #'make-strawberry item-builders)
(define-item spaghetti 5000 7)
(push #'make-spaghetti item-builders)

(define-item cake 10000 8)
(push #'make-cake item-builders)
(define-item rice-noodles 10000 16)
(push #'make-rice-noodles item-builders)

(define-item soy-sauce 20000 9)
(push #'make-soy-sauce item-builders)
(define-item tofu 20000 18)
(push #'make-tofu item-builders)

(define-item bomb 0 19)
(push #'make-bomb item-builders)
