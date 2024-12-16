(use-modules
 (gnu)
 (gnu services)
 (nongnu packages linux)
 (guix config)            ; Enable custom module imports
 (configs base)
 (configs users)
 (configs packages)
 (configs services)
 (configs desktop))       ; My modular configurations

(operating-system
 (inherit base-config)    ; Basic system configuration from core/base.scm

 (users user-accounts)    ; Import users from core/users.scm

 (packages system-packages) ; System-wide packages from core/packages.scm

 (services
  (append
   service-configurations  ; Imported services (Samba, Nginx, etc.)
   desktop-services))      ; Desktop configuration (GNOME, EXWM etc...)

 (bootloader bootloader-config) ; Bootloader config from core/base.scm

 (swap-devices swap-config)     ; Swap configuration from core/base.scm

 (file-systems file-systems-config)) ; File systems from core/base.scm
