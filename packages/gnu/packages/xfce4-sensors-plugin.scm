(define-module (gnu packages xfce4-sensors-plugin)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages xfce)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages nettools))

(define-public xfce4-sensors-plugin
  (package
    (name "xfce4-sensors-plugin")
    (version "1.4.4")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://archive.xfce.org/src/panel-plugins/"
                          name "/" (version-major+minor version) "/"
                          name "-" version ".tar.bz2"))
       (sha256
        (base32 "0jw0r1vxr4z0vbzqxr4d46dpj8vwsqmr4hjkzgxp86jc1k5kq3pq"))))
    (build-system gnu-build-system)
    (native-inputs
     (list pkg-config intltool))
    (inputs
     (list gtk+
           libxfce4ui
           libxfce4util
           xfce4-panel
           libnotify
           lm-sensors
           hddtemp
           netcat))
    (arguments
     `(#:configure-flags
       (list (string-append "--with-pathhddtemp="
                           (assoc-ref %build-inputs "hddtemp")
                           "/bin/hddtemp")
             (string-append "--with-pathnetcat="
                           (assoc-ref %build-inputs "netcat")
                           "/bin/netcat"))))
    (home-page "https://docs.xfce.org/panel-plugins/xfce4-sensors-plugin")
    (synopsis "Sensor plugin for Xfce panel")
    (description "This is a plugin for the Xfce panel that displays readings from
hardware sensors, including CPU temperature, fan speeds, and voltage readings.
It supports lm-sensors and hddtemp.")
    (license license:gpl2+)))
