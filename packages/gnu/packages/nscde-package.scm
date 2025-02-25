(use-modules (guix packages)
             (guix download)
             (guix build-system gnu)
             (guix licenses)
             ((gnu packages) #:prefix gnu:)
             (gnu packages pkg-config))

(define-public nscde
  (package
    (name "nscde")
    (version "2.3")
    (source (origin
      (method url-fetch)
      (uri (string-append
            "https://github.com/NsCDE/NsCDE/archive/refs/tags/"
            version ".tar.gz"))
      (sha256
       (base32
        "15xjars33k16w1sn6xlmbdfrn6183ah3yj5p8igqc6whdgqxakzw"))))
    (build-system gnu-build-system)
    (native-inputs (list pkg-config (gnu:@ (gnu packages shells) mksh)))
    (inputs (list (gnu:@ (gnu packages gettext) gettext-minimal)
                 (gnu:@ (gnu packages fvwm) fvwm)
                 (gnu:@ (gnu packages fonts) font-dejavu)
                 (gnu:@ (gnu packages fribidi) fribidi)
                 (gnu:@ (gnu packages dunst) dunst)
                 (gnu:@ (gnu packages gkrellm) gkrellm)
                 (gnu:@ (gnu packages gtk) gtk+)
                 (gnu:@ (gnu packages imagemagick) imagemagick)
                 (gnu:@ (gnu packages xorg) libxpm)
                 (gnu:@ (gnu packages xorg) libxext)
                 (gnu:@ (gnu packages xorg) libxft)
                 (gnu:@ (gnu packages xorg) libxt)
                 (gnu:@ (gnu packages xdisorg) rofi)
                 (gnu:@ (gnu packages compton) picom)
                 (gnu:@ (gnu packages python) python)
                 (gnu:@ (gnu packages python-xyz) python-pyyaml)
                 (gnu:@ (gnu packages qt) python-qtpy)
                 (gnu:@ (gnu packages stalonetray) stalonetray)
                 (gnu:@ (gnu packages xdisorg) xclip)
                 (gnu:@ (gnu packages xorg) xdpyinfo)
                 (gnu:@ (gnu packages xorg) xorg-rgb)
                 (gnu:@ (gnu packages xorg) xprop)
                 (gnu:@ (gnu packages xorg) xrefresh)
                 (gnu:@ (gnu packages xdisorg) xscreensaver)
                 (gnu:@ (gnu packages xorg) xset)
                 (gnu:@ (gnu packages xdisorg) xsettingsd)
                 (gnu:@ (gnu packages xorg) xterm)))
    (synopsis "Not so Common Desktop Environment")
    (description "Modern and functional CDE desktop based on FVWM.")
    (home-page "https://github.com/NsCDE/NsCDE")
    (license gpl3)))

nscde
