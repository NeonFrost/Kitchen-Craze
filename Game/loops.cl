(defvar spawn-accumulator 0)
(defvar spawn-accumulator-limit 500)
(defvar player-spawn-counter 1)

(defun level-loop ()
  (if (not spawn-accumulator)
      (setf spawn-accumulator 0))
  (if moving
      (move-player))
  (incf spawn-accumulator 20)
  (if (> spawn-accumulator spawn-accumulator-limit)
      (progn (spawn-item)
	     (setf spawn-accumulator 0)))
  (if (> (player-points player) (* 1000 player-spawn-counter))
      (progn (setf player-spawn-counter (* player-spawn-counter 10))
	     (decf spawn-accumulator-limit 50)))
  (if (<= spawn-accumulator-limit 39)
      (setf spawn-accumulator-limit 40))
  (if (<= (player-health player) 0)
      (setf state 'game-over)))
(add-loop-function level-loop level 'top)

(defun start-game ()
  (setf player (make-player))
  (setf (player-y player) (+ (menu-y kitchen-menu) (floor (/ (menu-height kitchen-menu) 4)) (floor (/ (menu-height kitchen-menu) 8)))
	(player-width player) (round (/ (menu-width kitchen-menu) 5))
	(player-height player) (- (floor (/ (menu-height kitchen-menu) 2)) (round (/ (menu-height kitchen-menu) 8)))
	falling-items nil
	frames-accumulator 0
	seconds-accumulator 0
	minutes-accumulator 0
	hours-accumulator 0
	spawn-accumulator 0
	spawn-accumulator-limit 500
	player-spawn-counter 1)
;;  (setf state 'level)
  (start-game-music))
