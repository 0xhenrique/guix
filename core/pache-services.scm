(define-module (pache-services)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:use-module (gnu services samba)
  #:use-module (gnu services web)
  #:export (service-configurations substitute-config))


(define service-configurations
  (list
   (service gnome-desktop-service-type)

   ;; Samba service configuration
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
guest only = yes
"))))

   ;; Nginx service configuration (WIP)
   (service nginx-service-type
            (nginx-configuration
             (server-blocks
              (list (nginx-server-configuration
                     (server-name '("localhost"))
                     (root "/srv/http")
                     (listen '("80")))))))))

;; Additional substitute URLs for Guix
(define substitute-config
  (modify-services %desktop-services
    (guix-service-type config =>
      (guix-configuration
       (inherit config)
       (substitute-urls
        (append (list "https://substitutes.nonguix.org")
                %default-substitute-urls))
       (authorized-keys
        (append (list (local-file "./signing-key.pub"))
                %default-authorized-guix-keys))))))
