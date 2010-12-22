(in-package #:cl-hackery)

(declaim (optimize debug))

(define-foreign-library libjcm
  (t (:default "/Users/jmckitrick/devel/cl-hackery/lib/cfunctions/libcfunctions")))

(use-foreign-library libjcm)

(defcstruct jcm-struct
  "Structure from jcm library."
  (the-int :int)
  (the-char :char)
  (the-float :float)
  (the-buffer :pointer))

(defcfun "jcm_do_nothing" :void)
(defcfun "jcm_return_int" :int)
(defcfun "jcm_process_int" :int (i :int))
(defcfun "jcm_access_pointer" :pointer (p :pointer))
(defcfun "jcm_access_string" :int (p :pointer))
(defcfun "jcm_process_doubles" :double (d :pointer))
(defcfun "jcm_process_struct" :void (s :pointer) (i :int) (c :char) (f :float))
(defcfun "jcm_return_dynamic" :pointer)
(defcfun "jcm_free_dynamic" :void (p :pointer))

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
      (format t "Double retval: ~A~%" retval)))
  (let ((retval (jcm-return-dynamic)))
    (format t "Returned pointer value: ~A~%" (mem-ref retval :char))
    (jcm-free-dynamic retval)
    (format t "Pointer freed: ~A~%" (mem-ref retval :char))))

(defun run-structs ()
  (with-foreign-object (my-struct 'jcm-struct)
    (setf (foreign-slot-value my-struct 'jcm-struct 'the-int) 42
          (foreign-slot-value my-struct 'jcm-struct 'the-char) (char-code (char "z" 0))
          (foreign-slot-value my-struct 'jcm-struct 'the-float) 3.0)
    (format t "Before access pointer to struct: ~A~%" (foreign-slot-value my-struct 'jcm-struct 'the-int))
    (format t "Before access pointer to struct: ~A~%" (code-char (foreign-slot-value my-struct 'jcm-struct 'the-char)))
    (format t "Before access pointer to struct: ~A~%" (foreign-slot-value my-struct 'jcm-struct 'the-float))
    (jcm-process-struct my-struct 99 (char-code (char "a" 0)) 2.0)
    (format t "After access pointer to struct: ~A~%" (foreign-slot-value my-struct 'jcm-struct 'the-int))
    (format t "After access pointer to struct: ~A~%" (code-char (foreign-slot-value my-struct 'jcm-struct 'the-char)))
    (format t "After access pointer to struct: ~A~%" (foreign-slot-value my-struct 'jcm-struct 'the-float))))

(defun run-cffi ()
  (run-simple-returns)
  (run-strings)
  (run-pointers)
  (run-structs))
