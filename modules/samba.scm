(define-module (system services samba)
  #:use-module (gnu services)
  #:use-module (gnu services samba)
  #:use-module (guix gexp)
  #:export (samba-server-service))

(define (samba-server-service)
  (service samba-service-type 
           (samba-configuration
            (enable-smbd? #t)
            (config-file 
             (plain-file "smb.conf" "\
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
guest only = yes\n")))))
