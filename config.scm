(add-to-load-path "/etc/core")

(use-modules (gnu) 
             (gnu services) 
             (nongnu packages linux) 
             (guix config) 
             (pache-base)
             (pache-users) 
             (pache-packages) 
             (pache-services) 
             (pache-desktop))

(operating-system
 (inherit base-config)        ; Import from pache-base
 (users user-accounts)        ; Import from pache-users
 (packages system-packages)   ; Import from pache-packages
 (services (append service-configurations 
                   desktop-services)) ; Combine services
 (bootloader bootloader-config) ; Bootloader from pache-base
 (swap-devices swap-config)     ; Swap from pache-base
 (file-systems file-systems-config)) ; File systems from pache-base
