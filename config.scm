(add-to-load-path "/etc/core")

(use-modules (gnu) 
             (gnu services) 
             (nongnu packages linux) 
             (guix config) 
             (pache-users) 
             (pache-packages) 
             (pache-services) 
             (pache-desktop)
             (pache-base))

(operating-system
 ;(inherit base-config)        ; Import from pache-base
(kernel linux)
   (firmware (list linux-firmware))
   (locale "en_GB.utf8")
   (timezone "Europe/Lisbon")
   (keyboard-layout (keyboard-layout "us"))
   (host-name "computer")
 (users user-accounts)        ; Import from pache-users
 (packages system-packages)   ; Import from pache-packages
 (services (append service-configurations 
                   desktop-services)) ; Combine services
 ;(bootloader bootloader-config) ; Bootloader from pache-base
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/nvme0n1"))
                (keyboard-layout keyboard-layout)))


 ;(swap-devices swap-config)     ; Swap from pache-base
  (swap-devices (list (swap-space
                        (target (uuid
                                 "bd49f319-3190-4144-ac8d-fdceada559c8")))))
 ;(file-systems file-systems-config)
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
                         (type "ext4")) %base-file-systems))) ; File systems from pache-base
