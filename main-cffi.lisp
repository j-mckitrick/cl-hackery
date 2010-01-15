(in-package #:cl-hackery)

(declaim (optimize debug))

(define-foreign-library libjcm
  (t (:default "/Users/jmckitrick/devel/cl-hackery/lib/cfunctions/libcfunctions")))

(use-foreign-library libjcm)

(defcfun "jcm_do_nothing" :void)
(defcfun "jcm_return_int" :int)
(defcfun "jcm_process_int" :int (i :int))
(defcfun "jcm_access_pointer" :pointer (p :pointer))
(defcfun "jcm_access_string" :int (p :pointer))
(defcfun "jcm_process_doubles" :double (d :pointer))

(defun run-simple-returns ()
  (format t "Do nothing: ~A~%" (jcm-do-nothing))
  (format t "Return int: ~A~%" (jcm-return-int))
  (format t "Process int: ~A~%" (jcm-process-int 88)))

(defun run-strings ()
  (with-foreign-string (buf "Hello, world!")
    (format t "Before access string: ~A~%" (foreign-string-to-lisp buf))
	(jcm-access-string buf)
	(format t "After access string: ~A~%" (foreign-string-to-lisp buf))))

(defun run-pointers ()
  (with-foreign-pointer (my-int 1)
    (setf (mem-ref my-int :int) 9)
    (format t "Before access pointer: ~A~%" (mem-ref my-int :int))
    (jcm-access-pointer my-int)
	(format t "After access pointer: ~A~%" (mem-ref my-int :int)))
  (with-foreign-pointer (my-double 1)
	(setf (mem-ref my-double :double) 2.0d0)
    (format t "Before access pointer to double: ~A~%" (mem-ref my-double :double))
	(let ((retval (jcm-process-doubles my-double)))
	  (format t "After access pointer to double: ~A~%" (mem-ref my-double :double))
      (format t "Double retval: ~A~%" retval))))

(defun run-cffi ()
  (run-simple-returns)
  (run-strings)
  (run-pointers))
