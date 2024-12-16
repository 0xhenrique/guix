(define desktop-services
  (append
   %desktop-services
   (list
    (set-xorg-configuration
     (xorg-configuration (keyboard-layout (keyboard-layout "us")))))))
