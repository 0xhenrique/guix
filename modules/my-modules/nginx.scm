(define-module (my-modules nginx)
  #:use-module (gnu)
  #:use-module (gnu services web)
  #:export (my-nginx-service))

;; Read more: https://guix.gnu.org/manual/en/html_node/Web-Services.html
(define my-nginx-service
  (service nginx-service-type
           (nginx-configuration
            (server-blocks
             (list
              (nginx-server-configuration
               (server-name '("wired"))
               (root "/var/www/wired")
               (locations
                (list
                 (nginx-location-configuration
                  (uri "/")
                  (body '("autoindex on;")))))
               (listen '("80"))))))))
