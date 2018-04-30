(defvar game-over-menus nil)
(define-menu game-over-menu game-over-menus
  (round (/ *screen-width* 4)) (round (/ *screen-height* 4))
  (round (* (/ *screen-width* 4) 2)) (round (* (/ *screen-height* 4) 2))
  +brown+ +dark-red+)
(defvar g-r 255)
(defvar g-g 255)
(defvar g-b 255)
(defvar color-state 'down)

(defun render-game-over-screen ()
  (render-room)
  (draw-menu game-over-menu)
  (let ((game-over-buffer (create-text-buffer "!! !! Game Over !! !!"
					      :width (* (car character-size) (length "!! !! Game Over !! !!"))
					      :height (* (cadr character-size) 4)
					      :to-texture t
					      :string-case 'text)))
      (tex-blit game-over-buffer
		:dest (sdl2:make-rect (menu-x game-over-menu)
				      (+ (menu-y game-over-menu) (round (/ (menu-height game-over-menu) 4)) (round (/ (menu-height game-over-menu) 8)))
				      (menu-width game-over-menu)
				      (round (* (/ (menu-height game-over-menu) 4) 3)))
		:color (list g-r g-g g-b))
      (reset-text-buffer game-over-buffer))
  (if (eq color-state 'down)
      (progn (decf g-r 5)
	     (decf g-g 5)
	     (decf g-b 5)
	     (if (< g-r 127)
		 (setf color-state 'up)))
      (progn (incf g-r 5)
	     (incf g-g 5)
	     (incf g-b 5)
	     (if (> g-r 245)
		 (setf color-state 'down)))))
(add-to-state-render render-game-over-screen game-over)
