(defsystem #:cl-hackery
  :description "Try lots of cool lisp stuff."
  :components
  ((:file "defpackage")
   (:file "main-cffi")
   (:file "main-list"))
  :serial t
  :depends-on (:cffi))
