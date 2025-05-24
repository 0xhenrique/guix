(define-module (my-modules packages)
  #:use-module (gnu packages)
  #:export (my-packages))

(define my-packages
  (packages (append (list
					 (specification->package "emacs")
					 (specification->package "emacs-exwm")
					 (specification->package "git")
					 (specification->package "gimp")
					 (specification->package "nicotine+")
					 (specification->package "mpv")
					 (specification->package "flameshot")
					 (specification->package "rhythmbox")
					 (specification->package "kitty")
					 (specification->package "btop")
					 (specification->package "deluge")
					 (specification->package "emacs-desktop-environment"))
					%base-packages)))
