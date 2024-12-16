(define base-config
  (operating-system
   (kernel linux)
   (firmware (list linux-firmware))
   (locale "en_GB.utf8")
   (timezone "Europe/Lisbon")
   (keyboard-layout (keyboard-layout "us"))
   (host-name "computer")))

(define bootloader-config
  (bootloader-configuration
   (bootloader grub-bootloader)
   (targets (list "/dev/nvme0n1"))
   (keyboard-layout (keyboard-layout "us"))))

(define swap-config
  (list (swap-space
         (target (uuid "bd49f319-3190-4144-ac8d-fdceada559c8")))))

(define file-systems-config
  (cons* (file-system
           (mount-point "/boot/efi")
           (device (uuid "73D8-0D0A" 'fat32))
           (type "vfat"))
         (file-system
           (mount-point "/")
           (device (uuid "1326068e-af88-4723-80d1-c69029201c8d" 'ext4))
           (type "ext4"))
         %base-file-systems))
