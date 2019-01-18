(defsystem :game
  :author "Brandon Blundell | Neon Frost"
  :maintainer "Brandon Blundell | Neon Frost"
  :license "GPL v3"
  :version "0.9"
  :description "Description."
  :build-operation program-op
  :build-pathname "vidya"
  :entry-point "cl-user::main"
  :depends-on (:sdl2
	       :sdl2-image
	       :sdl2-mixer)
  :components ((:file "values" :type "cl")
	       (:file "states" :type "cl")
	       (:module "engine"
			:serial t
			:components
			((:module "Graphics Code"
				  :serial t
				  :components
				  ((:file "colors")
				   (:file "string" :type "cl")
				   (:file "library")
				   (:module "Screens"
					    :serial t
					    :components
					    ((:file "Menus")))))
			 (:module "logic"
				  :serial t
				  :components
				  ((:file "entities" :type "cl")
				   (:file "vectors")
				   (:file "math" :type "cl")
				   ;;;;(:file "rpg-lib" :type "cl")
				   (:file "move-platformer" :type "cl")))
			 (:module "audio"
				  :serial t
				  :components
				  ((:file "music")))
			 (:module "input"
				  :serial t
				  :components
				  ((:file "mouse" :type "cl")
				   (:file "keyboard" :type "cl")))
			 (:file "loops" :type "cl")
			 (:file "render-engine" :type "cl")))
	       (:module "Game"
			:serial t
			:components
			((:file "init" :type "cl")
			 (:file "items" :type "cl")
			 (:file "item-builders" :type "cl")
			 (:file "move" :type "cl")
			 (:file "loops" :type "cl")
			 (:file "game-over-screen" :type "cl")
			 (:file "pause-screen" :type "cl")
			 (:file "room-screen" :type "cl")
			 (:file "title-screen" :type "cl")
			 (:file "render-level" :type "cl")
			 (:file "input" :type "cl")
			 ))
	       (:file "init-assets" :type "cl")
	       (:file "Main")))


(defsystem :game/kc-t
  :build-operation program-op
  :build-pathname "KC-T"
  :entry-point "main"
  :depends-on ("game")
  :components ())
