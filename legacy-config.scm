;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules
 (gnu)
 (gnu services samba)
 (gnu services nginx)
 (nongnu packages linux))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
 (kernel linux)
 (firmware (list linux-firmware))
  (locale "en_GB.utf8")
  (timezone "Europe/Lisbon")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "computer")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "arisu")
                  (comment "arisu")
                  (group "users")
                  (home-directory "/home/arisu")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "emacs")
                          (specification->package "emacs-exwm")
                          (specification->package
                           "emacs-desktop-environment")) %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
(services
 (append (list
          (service gnome-desktop-service-type)
          (service samba-service-type
                   (samba-configuration
                    (enable-smbd? #t)
                    (config-file (plain-file "smb.conf" "\
[global]
map to guest = Bad User
logging = syslog@1

[public]
browsable = yes
path = /public
read only = no
guest ok = yes
guest only = yes\n"))))
          (set-xorg-configuration
           (xorg-configuration (keyboard-layout keyboard-layout))))
         ;; Append the modified guix-service configuration
         (modify-services %desktop-services
           (guix-service-type config =>
             (guix-configuration
              (inherit config)
              (substitute-urls
               (append (list "https://substitutes.nonguix.org")
                       %default-substitute-urls))
              (authorized-keys
               (append (list (local-file "./signing-key.pub"))
                       %default-authorized-guix-keys)))))))

  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/nvme0n1"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "bd49f319-3190-4144-ac8d-fdceada559c8")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "73D8-0D0A"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "1326068e-af88-4723-80d1-c69029201c8d"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
