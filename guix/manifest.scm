;; Install user specific packages with the following command
;; guix package -m manifest.scm
;; Implying that you're on the same directory as manifest.scm

(specifications->manifest
  '("vim"
    "emacs"
    "git"
    "go"
    "glibc"
    "ripgrep"
    "rust-analyzer"
    "rust-cargo"
    "clojure"
    "zip"
    "unzip"
    "pulsemixer"
    "xrandr"
    "arandr"
    "nonguix:librewolf"
    "flameshot"
    "figlet"
    "transmission"
    "mpv"
    "btop"
    "gimp"
    "blueman"
    "icedove"
    "feh"
    "picom"
    "font-iosevka"
    "setxkbmap"
    "xdg-utils"
    "htop"))
