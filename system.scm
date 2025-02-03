;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   ____   _   _   ___  __  __ ;;
;;  / ___| | | | | |_ _| \ \/ / ;;
;; | |  _  | | | |  | |   \  /  ;;
;; | |_| | | |_| |  | |   /  \  ;;
;;  \____|  \___/  |___| /_/\_\ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-load-path (string-append (dirname (current-filename))
                                "/modules"))

(use-modules (gnu)
	     (my-modules filesystems)
	     (my-modules nginx)
	     (my-modules samba)
	     (nongnu packages linux))

(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (locale "en_GB.utf8")
  (timezone "Europe/Lisbon")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "wired")
  (kernel linux)
  (firmware (list linux-firmware))

  (users (cons* (user-account
                  (name "arisu")
                  (comment "arisu")
                  (group "users")
                  (home-directory "/home/arisu")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  (services (append (list 
		     my-samba-service
		     my-nginx-service
		     (service xfce-desktop-service-type)
		     (service openssh-service-type)
		     (set-xorg-configuration
		      (xorg-configuration (keyboard-layout keyboard-layout))))
		    %desktop-services))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  (swap-devices (list (swap-space
                        (target (uuid
                                 "b47f38e0-3f1f-43be-b255-e708127ceccd")))))

  (file-systems my-file-systems))
