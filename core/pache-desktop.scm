(define-module (pache-desktop)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)
  #:use-module (gnu system keyboard)
  #:export (desktop-services))

(define desktop-services
  (append
   %desktop-services
   (list
    (set-xorg-configuration
     (xorg-configuration (keyboard-layout (keyboard-layout "us")))))))
