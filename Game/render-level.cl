(define-buffer room-buffer)
(defvar seconds-accumulator 0)
(defvar minutes-accumulator 0)
(defvar hours-accumulator 0)
(defvar frames-accumulator 0)
(defvar fps 15)

(defun render-background ()
  (if room-buffer
      (tex-blit room-buffer
		:src (sdl2:make-rect 0 0
				     (sdl2:texture-width room-buffer)
				     (sdl2:texture-height room-buffer))
		:dest (sdl2:make-rect (menu-x kitchen-menu)
				      (+ (menu-y kitchen-menu) (floor (/ (menu-height kitchen-menu) 4)))
				      (menu-width kitchen-menu)
				      (floor (/ (menu-height kitchen-menu) 2))))
      (setf room-buffer (sdl2:create-texture-from-surface renderer (sdl2-image:load-image "Game/assets/background.png")))))

(defun render-stats ()
  ;;health is represented by the tofu cell
  (let ((tofu-width (round (/ (menu-width status-menu) 20)))
	(tofu-height (- (menu-height status-menu) 8)))
    (loop for x below (player-health player)
       do (draw-cell items-sheet 18
		     (round (+ (- (/ (menu-width status-menu) 2) (* 5 (/ tofu-width 2))) (* x (round (/ tofu-width 2)))))
		     (menu-y status-menu) :width tofu-width :height tofu-height :angle 0)))
  ;;display player score on the far left
  (let ((stats-buffer (create-text-buffer (write-to-string (player-points player))
					  :width (* (car character-size) 20) :height (cadr character-size)
					  :to-texture t :string-case 'text))
	(time-buffer (create-text-buffer (combine-strings (write-to-string hours-accumulator) "h "
							  (write-to-string minutes-accumulator) "m "
							  (write-to-string seconds-accumulator) "s")
					 :width (* (car character-size) 16) :height (cadr character-size)
					 :to-texture t :string-case 'text)))
    (tex-blit stats-buffer
	      :dest (sdl2:make-rect (menu-x status-menu) (menu-y status-menu) (round (/ (menu-width status-menu) 4)) (menu-height status-menu)))
    (reset-text-buffer stats-buffer)
    (tex-blit time-buffer
	      :src (sdl2:make-rect 0 0 (sdl2:texture-width time-buffer) (sdl2:texture-height time-buffer))
	      :dest (sdl2:make-rect (+ (menu-x status-menu) (round (* (/ *screen-width* 6) 5))) (menu-y status-menu)
				    (round (/ *screen-width* 4)) (menu-height status-menu)))
    (reset-text-buffer time-buffer)
    (if (eq state 'level)
	(progn (incf frames-accumulator 1)
	       (if (> frames-accumulator fps)
		   (progn (incf seconds-accumulator 1)
			  (setf frames-accumulator 0)))
	       (if (> seconds-accumulator 59)
		 (progn (incf minutes-accumulator 1)
			(setf seconds-accumulator 0)))
	       (if (> minutes-accumulator 59)
		   (progn (incf hours-accumulator 1)
			  (setf minutes-accumulator 0)))))))

(defun render-player ()
  (draw-cell player-sheet (player-current-cell player)
	     (player-x player) (player-y player)
	     :width (player-width player) :height (player-height player)))

(defun render-items ()
  (if falling-items
      (loop for item in falling-items
	 do (if (eq state 'level)
		(progn (incf (item-angle item) 45)
		       (incf (item-y item) 16)))
	   (draw-cell items-sheet (item-cell item) (item-x item) (item-y item) :width 64 :height 64 :angle (item-angle item))
	   (if (< (player-current-cell player) 4)
	       (if (and (> (item-y item) (+ (player-y player) (round (/ (player-height player) 4))))
			(< (item-y item) (+ (player-y player) (round (* (/ (player-height player) 4) 3))))
			(< (item-x item) (- (+ (player-x player) (player-width player)) (round (/ (player-width player) 6)) 16))
			(> (item-x item) (- (+ (player-x player) (player-width player)) (round (/ (player-width player) 2)) 16)))
		   (if (not (bomb-p item));;(< (item-cell item) 19)
		       (progn (incf (player-points player) (item-amount item))
			      (setf falling-items (remove item falling-items)))
		       (progn (decf (player-health player) 1)
			      (setf falling-items (remove item falling-items)))))
	       (if (and (> (item-y item) (+ (player-y player) (round (/ (player-height player) 4))))
			(< (item-y item) (+ (player-y player) (round (* (/ (player-height player) 4) 3))))
			(> (item-x item) (+ (player-x player) (round (/ (player-width player) 10))))
			(< (item-x item) (+ (player-x player) (round (/ (player-width player) 4)) (round (/ (player-width player) 16)))))
		   (if (< (item-cell item) 19)
		       (progn (incf (player-points player) (item-amount item))
			      (setf falling-items (remove item falling-items)))
		       (progn (decf (player-health player) 1)
			      (setf falling-items (remove item falling-items))))))
	   (if (> (item-y item) (- *screen-height* 16))
	       (setf falling-items (remove item falling-items))))
      (spawn-item)))

(defun render-room ()
  (room-screen)
  (render-background)
  (render-player)
  (render-items)
  (draw-menu status-menu)
  (render-stats))
(add-to-state-render render-room level)
