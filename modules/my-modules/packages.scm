(define-module (my-modules packages)
  #:use-module (gnu packages)
  #:export (my-packages))

(define my-packages
  (packages (append (list (specification->package "emacs")
			  (specification->package "emacs-exwm")
			  (specification->package "git")
			  (specification->package "nicotine+")
			  (specification->package "qbittorrent")
			  (specification->package "emacs-exwm")
			  (specification->package "emacs-desktop-environment"))
		    %base-packages)))
