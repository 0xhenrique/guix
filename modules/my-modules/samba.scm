(define-module (my-modules samba)
  #:use-module (gnu)
  #:use-module (gnu services samba)
  #:export (my-samba-service))

;;Samba provides network shares for folders and printers using the SMB/CIFS protocol commonly used on Windows.
;;It can also act as an Active Directory Domain Controller (AD DC) for other hosts in an heterougenious network with different types of Computer systems. 
;; Read more: https://guix.gnu.org/manual/en/html_node/Samba-Services.html
(define my-samba-service
    (service samba-service-type (samba-configuration
				 (enable-smbd? #t)
				 (config-file (plain-file "smb.conf" "
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
guest only = yes\n
")))))
