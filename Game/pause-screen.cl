(defvar pause-menus nil)
(define-menu pause-menu pause-menus
  (round (- (/ *screen-width* 2) (/ *screen-width* 8)))
  (round (- (/ *screen-height* 2) (/ *screen-height* 8)))
  (round (/ *screen-width* 4))
  (round (/ *screen-height* 4))
  +dark-pastel-grey+ +black+)
(define-screen pause-screen pause-menus)

(defun render-paused-screen ()
  (render-room)
  (pause-screen)
  (render-box (menu-x pause-menu) (+ (* *selection-row* (cadr character-size)) (round (/ (cadr character-size) 2)) (menu-y pause-menu))
	      (menu-width pause-menu) (cadr character-size) :color +dark-natural-green+)
  (let ((pause-text-buffer (create-text-buffer (start-string "   Resume   "
							     " Main  Menu "
							     " Quit  Game ")
					       :width (* (car character-size) 13)
					       :height (* (cadr character-size) 3)
					       :to-texture t :string-case 'text)))
    (tex-blit pause-text-buffer
	      :src (sdl2:make-rect 0 0
				   (sdl2:texture-width pause-text-buffer)
				   (sdl2:texture-height pause-text-buffer))
	      :dest (sdl2:make-rect (+ (menu-x pause-menu) (round (/ (menu-width pause-menu) 8)) (car character-size))
				    (+ (menu-y pause-menu) (/ (cadr character-size) 2))
				    (* (round (/ (menu-width pause-menu) 4)) 3)
				    (* (cadr character-size) 3)))
    (reset-text-buffer pause-text-buffer)))
(add-to-state-render render-paused-screen paused)
