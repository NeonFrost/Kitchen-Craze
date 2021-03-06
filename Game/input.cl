(defun exit-to-main-menu ()
  (setf state 'title)
  (setf *selection-row* 0)
  (sdl2-mixer:halt-music)
  (switch-track-to main-menu-track))

(add-key :scancode-up title :down (change-selection 'up))
(add-key :scancode-down title :down (change-selection 'down))
(add-key :scancode-right title :down (if (eq sub-state 'options)
					 (case *selection-row*
					   (0 (if (< max-volume 124)
						  (progn (incf max-volume 5)
							 (setf +track-volume+ max-volume)
							 (sdl2-mixer:volume-music +track-volume+))))
					   (1 (incf resolution 1)
					      (if (> resolution (1- (length resolution-list)))
						  (setf resolution 0))
					      (update-window-size)))))
(add-key :scancode-left title :down (if (eq sub-state 'options)
					(case *selection-row*
					  (0 (if (> max-volume 5)
						 (progn (decf max-volume 5)
							(setf +track-volume+ max-volume)
							(sdl2-mixer:volume-music +track-volume+))))
					  (1 (decf resolution 1)
					     (if (< resolution 0)
						 (setf resolution (1- (length resolution-list))))
					     (update-window-size)))))
(add-key :scancode-return title :up (confirm-selection))
(add-key :scancode-escape title :up (quit-game))	 
(add-key :scancode-z title :up (confirm-selection))

(add-key :scancode-up paused :down (change-selection 'up))
(add-key :scancode-down paused :down (change-selection 'down))
(add-key :scancode-z paused :up (confirm-selection))
(add-key :scancode-return paused :up (confirm-selection))
(add-key :scancode-x paused :up (case sub-state
				  (options (setf sub-state nil)
					   (setf selection 3))
				  (otherwise (setf state 'level)
					     (setf selection 0))))

(add-key :scancode-return level :down (pause-game))
(add-key :scancode-left level :down (setf moving 'left))
(add-key :scancode-right level :down (setf moving 'right))

(add-key :scancode-right level :up (stop-moving))
(add-key :scancode-left level :up (stop-moving))

(add-key :scancode-z game-over :up (exit-to-main-menu))
