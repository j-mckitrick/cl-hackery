(in-package #:cl-hackery)

(declaim (optimize debug))

(defparameter *my-list-1* (list 1 2 3))
(defparameter *my-list-2* (list 4 5 6))
(defparameter *my-list-3* ())
(defparameter *my-junk* 8)

(defun run-list ()
  (setf *my-list-3* ())
  (format t "List 1: ~A~%" *my-list-1*)
  (format t "List 2: ~A~%" *my-list-2*)
  (format t "List 3: ~A~%" *my-list-3*)
  (setf *my-list-3* (list *my-list-1* *my-list-2*))
  (format t "LIST List 3: ~A~%" *my-list-3*)
  (setf *my-list-3* (list* *my-list-1* *my-list-2*))
  (format t "LIST* List 3: ~A~%" *my-list-3*)
  (setf *my-list-3* (list *my-list-1* *my-list-2* *my-junk*))
  (format t "LIST postpend List 3: ~A~%" *my-list-3*)
  (setf *my-list-3* (list* *my-list-1* *my-list-2* *my-junk*))
  (format t "LIST* postpend List 3: ~A~%" *my-list-3*)
  (setf *my-list-3* (list *my-junk* *my-list-1* *my-list-2*))
  (format t "LIST prepend List 3: ~A~%" *my-list-3*)
  (setf *my-list-3* (list* *my-junk* *my-list-1* *my-list-2*))
  (format t "LIST* prepend List 3: ~A~%" *my-list-3*))