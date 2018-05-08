(define-state game-over)
(define-state title)
(define-state level)
(define-state paused)
(define-track main-menu-track "Game/assets/Main Menu.ogg") ;;;;:path is relevant to where the program is started
(define-track level-track "Game/assets/Level.ogg")
(defvar moving nil)

(defun confirm-selection ()
  (case state
    (title (case sub-state
	     (top (case *selection-row*
		    (0 (setf changing-state 'level))
;;;;		       (start-game))
		    (1 (go-to-options))
		    (2 (quit-game))))
	     (options (if (eq *selection-row* 2)
			  (progn (setf *selection-row* 0)
				 (setf sub-state 'top))))))
    (paused (case *selection-row*
	      (0 (resume-game))
	      (1 (exit-to-main-menu))
	      (2 (quit-game))))))

(defun go-to-options ()
  (setf *selection-row* 0)
  (setf sub-state 'options))

