(defvar room-menus nil)
(define-menu status-menu room-menus
  0 0 *screen-width* (round (/ *screen-height* 20))
  +dark-pastel-grey+ +black+)
(define-menu kitchen-menu room-menus
  0 (+ (menu-height status-menu) (round (/ *screen-height* 20))) *screen-width* (round (- *screen-height* (* (/ *screen-height* 20) 3)))
  +black+ +black+)
(define-screen room-screen room-menus)

