(define-module (arisu services)
  #:use-module (gnu)
  #:use-module (gnu services web)
  #:use-module (gnu services samba)
  #:use-module (gnu services audio)
  #:export (arisu-nginx-service
			arisu-mpd-service
            arisu-samba-service))

;; Web server for local development and file serving
;; Serves static files with directory browsing
(define arisu-nginx-service
  (service nginx-service-type
           (nginx-configuration
            (server-blocks
             (list
              (nginx-server-configuration
               (server-name '("wired" "localhost"))
               (root "/var/www/wired")
               (locations
                (list
                 (nginx-location-configuration
                  (uri "/")
                  (body '("autoindex on;"
                         "autoindex_exact_size off;"
                         "autoindex_localtime on;")))))
               (listen '("80" "127.0.0.1:80"))))))))

;; Samba file sharing for local network
;; Guest access to shared drives
(define arisu-samba-service
  (service samba-service-type 
           (samba-configuration
            (enable-smbd? #t)
            (config-file 
             (plain-file "smb.conf" "
[global]
# Security settings
map to guest = Bad User
logging = syslog@1
server string = hack me
workgroup = WORKGROUP

# Performance
socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072

[hdd1]
comment = Primary Drive
browsable = yes
path = /public/hdd1
read only = no
guest ok = yes
guest only = yes
create mask = 0644
directory mask = 0755

[hdd2]
comment = Secondary Drive  
browsable = yes
path = /public/hdd2
read only = no
guest ok = yes
guest only = yes
create mask = 0644
directory mask = 0755
")))))

;; Music Player Daemon
;; Accessible via Emacs, ncmpcpp, web etc...
(define arisu-mpd-service
  (service mpd-service-type
           (mpd-configuration
            ;; Run as arisu so it can access my music files
            (user "arisu")
            (group "users")
            
            ;; Music directory - adjust this to where your music is stored
            (music-dir "/public/hdd1/Music")
            
            ;; MPD state files
            (playlist-dir "/home/arisu/.config/mpd/playlists")
            (db-file "/home/arisu/.config/mpd/database")
            (state-file "/home/arisu/.config/mpd/state")
            (sticker-file "/home/arisu/.config/mpd/sticker.sql")
            (pid-file "/home/arisu/.config/mpd/pid")
            
            ;; Network access
            (address "localhost")
            (port 6600)
            
            ;; Audio output configuration
            (outputs (list (mpd-output
                           (name "PulseAudio")
                           (type "pulse")
                           (mixer-type "software"))
                          
                          ;; HTTP streaming output for web clients
                          (mpd-output
                           (name "HTTP Stream")
                           (type "httpd")
                           (port 8000)
                           (format "44100:16:2")
                           (always-on? #t)
                           (tags? #t)
                           (extra-options
                            '((encoder . "lame")
                              (bitrate . "128")))))))))
