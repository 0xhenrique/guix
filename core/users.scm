(define user-accounts
  (cons* (user-account
           (name "arisu")
           (comment "arisu")
           (group "users")
           (home-directory "/home/arisu")
           (supplementary-groups '("wheel" "netdev" "audio" "video")))
         %base-user-accounts))
