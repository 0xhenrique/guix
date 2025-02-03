(define-module (my-modules filesystems)
  #:use-module (gnu)
  #:export (my-file-systems))

;; The list of file systems that get "mounted".  The unique
;; file system identifiers there ("UUIDs") can be obtained
;; by running 'blkid' in a terminal.
;; Read more: https://guix.gnu.org/manual/en/html_node/File-Systems.html
(define my-file-systems
  (cons* (file-system
	  (mount-point "/boot/efi")
	  (device (uuid "73D8-0D0A"
			'fat32))
	  (type "vfat"))
	 (file-system
	  (mount-point "/")
	  (device (uuid
		   "36c13adb-fdd8-47e0-b77c-f689a3dfbd18"
		   'ext4))
	  (type "ext4"))
	 (file-system
	  (mount-point "/public/hdd1")
	  (device (uuid "46630077-0942-4f80-add4-584a0c53838a"
			'ext4))
	  (type "ext4"))
	 (file-system
	  (mount-point "/public/hdd2")
	  (device (uuid "bf91bd86-c9ea-4675-95a8-cc172afdec29"
			'ext4))
	  (type "ext4"))
	 %base-file-systems))
