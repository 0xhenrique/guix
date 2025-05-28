;; Extend the module load path to include our custom modules
(eval-when (compile load eval)
  (set! %load-path
        (cons (dirname (current-filename))
              %load-path)))
