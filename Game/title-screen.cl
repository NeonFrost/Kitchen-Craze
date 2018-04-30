(defvar title-menus nil)
(define-menu title-menu title-menus 0 0 *screen-width* *screen-height* '(127 127 127 255) +black+)
(define-screen title-screen title-menus)
(defvar game-info (start-string "        Soi Boi is not trademarked, is in the public domain, and is *not* for sale          "
				"Soi Boi's assets were created by Brandon Blundell (Neon Frost) and are in the public domain "))
(defvar title-screen-string (start-string "Begin New Game"
					  "   Settings   "
					  "     Quit     "))
(defun render-options-screen ()
  (render-box (round (- (/ *screen-width* 2) (/ *screen-width* 8)))
	      (round (+ (- (/ *screen-height* 2) (* (cadr character-size) 2)) (* (cadr character-size) *selection-row*)))
	      (* (car character-size) 12)
	      (cadr character-size)
	      :color +dark-red+)
  (let ((options-buffer (create-text-buffer (start-string "  Volume  "
							  (combine-strings "Resolution " (write-to-string *screen-width*) " X " (write-to-string *screen-height*))
							  "Main  Menu")
					    :width (* (car character-size) 30)
					    :height (* (cadr character-size) 3)
					    :to-texture t
					    :string-case 'text)))
    (tex-blit options-buffer
	      :dest (sdl2:make-rect (round (+ (- (/ *screen-width* 2) (/ *screen-width* 8)) (/ *screen-width* 90)))
				    (round (- (/ *screen-height* 2) (* (cadr character-size) 2)))
				    (sdl2:texture-width options-buffer)
				    (sdl2:texture-height options-buffer)))
    (reset-text-buffer options-buffer)))

(defun render-title-screen ()
  (case sub-state
    (options (render-options-screen))
    (otherwise (title-screen)
	       (let ((game-info-buffer (create-text-buffer game-info
							   :width (* (car character-size) (position #\newline game-info))
							   :height (* (cadr character-size) 3)
							   :to-texture t
							   :string-case 'text))
		     (title-name-buffer (create-text-buffer title-name
							    :width (* (car character-size) (length title-name))
							    :height (cadr character-size)
							    :to-texture t :string-case 'text))
		     (title-screen-buffer (create-text-buffer title-screen-string
							      :width (* (car character-size) (length " Begin New Game ")) :height (* (cadr character-size) 3)
							      :to-texture t :string-case 'text)))
		 (tex-blit game-info-buffer
			   :dest (sdl2:make-rect (menu-x title-menu)
						 (- (round (* (/ (menu-height title-menu) 10) 9)) (cadr character-size))
						 (menu-width title-menu)
						 (* (cadr character-size) 6)))
		 (reset-text-buffer game-info-buffer)
		 (tex-blit title-name-buffer
			   :dest (sdl2:make-rect (round (- (/ *screen-width* 2) (/ (* (car character-size) (length title-name)) 2)))
						 (menu-y title-menu)
						 (sdl2:texture-width title-name-buffer)				      
						 (* (cadr character-size) 2)))
		 (reset-text-buffer title-name-buffer)
		 (render-box (- (round (/ *screen-width* 2)) (* 8 (car character-size)))
			     (+ (menu-y title-menu) (- (round (/ *screen-height* 2)) (* 4 (cadr character-size)) (/ (cadr character-size) 2)) (* *selection-row* (cadr character-size) 2) (/ (cadr character-size) 4))
			     (+ (* (length "Begin New Game") (car character-size)) (* (car character-size) 2))
			     (* (cadr character-size) 2)
			     :color +dark-pastel-red+)
		 (tex-blit title-screen-buffer
			   :dest (sdl2:make-rect (- (round (/ *screen-width* 2)) (* 7 (car character-size)))
						 (- (round (/ *screen-height* 2)) (* 4 (cadr character-size)))
						 (* (length " Begin New Game ") (car character-size))
						 (* (cadr character-size) 6)))
		 (reset-text-buffer title-screen-buffer)
		 ))))

(add-to-state-render render-title-screen title)
