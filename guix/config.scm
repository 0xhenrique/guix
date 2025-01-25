;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.

(use-modules
 (gnu)
 (gnu services)
 (guix gexp)
 (gnu services samba)
 (gnu services databases)
 (gnu services base)
 (gnu services desktop)
 (gnu services web)
 (nongnu packages linux))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
 (kernel linux)
 (firmware (list linux-firmware))
 (locale "en_GB.utf8")
 (timezone "Europe/Lisbon")
 (keyboard-layout (keyboard-layout "us"))
 (host-name "computer")

 ;; User accounts
 (users (cons* (user-account
                 (name "arisu")
                 (comment "arisu")
                 (group "users")
                 (home-directory "/home/arisu")
                 (supplementary-groups '("wheel" "netdev" "audio" "video")))
               %base-user-accounts))

 ;; Packages installed system-wide
 (packages (append (list
                    (specification->package "xfce")
                    (specification->package "sddm")
                    (specification->package "xfce4-panel")
                    (specification->package "xfce4-session")
                    (specification->package "xfce4-settings")
                    (specification->package "xfce4-terminal")
                    (specification->package "emacs-desktop-environment")
		    (specification->package "windowmaker"))
                  %base-packages))

 ;; System services
 (services
  (append
   (list
    ;; Enable Samba server
    (service samba-service-type (samba-configuration
				 (enable-smbd? #t)
				 (config-file (plain-file "smb.conf" "\
[global]
map to guest = Bad User
logging = syslog@1

[hdd1]
browsable = yes
path = /public/hdd1
read only = no
guest ok = yes
guest only = yes\n

[hdd2]
browsable = yes
path = /public/hdd2
read only = no
guest ok = yes
guest only = yes\n"))))

    ;; Enable Postgres
    (service postgresql-service-type
             (postgresql-configuration
              (postgresql (specification->package "postgresql@14.13"))))

    ;; Enable Nginx server
(service nginx-service-type
         (nginx-configuration
          (server-blocks
           (list
            (nginx-server-configuration
             (server-name '("default"))
             (root "/srv/http")
             (listen '("80"))
             )))))

    ;; Configure the X server
    (set-xorg-configuration
     (xorg-configuration (keyboard-layout keyboard-layout))))

   ;; Modify existing services like samba, nginx, etc.
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

 ;; Bootloader configuration
 (bootloader (bootloader-configuration
              (bootloader grub-bootloader)
              (targets (list "/dev/nvme0n1"))
              (keyboard-layout keyboard-layout)))
 (swap-devices (list (swap-space
                       (target (uuid
                                "bd49f319-3190-4144-ac8d-fdceada559c8")))))

 ;; File systems
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
                       (type "ext4"))
		     (file-system
                       (mount-point "/public/hdd1")
                       (device (uuid "46630077-0942-4f80-add4-584a0c53838a"
                                     'ext4))
                       (type "ext4"))
		     (file-system
                       (mount-point "/public/hdd2")
                       (device (uuid "bf91bd86-c9ea-4675-95a8-cc172afdec29"
                                     'ext4))
                       (type "ext4"))
		     %base-file-systems)))
