(in-package #:cl-hackery)

(declaim (optimize debug))

(defmacro abc (a b c)
  `(defmacro abc% (d e f)
     `(list ,,a ,,b ,,c ',,a ,',a ,',b ,',c ,d ,e ,f)))

(defmacro jmac1 (a b c)
  `(list ,a ,b ,c 1 2 3))

(defmacro jmac2 (a b c)
  ``(list ,',a ,,b ,,c 1 2 3))

(defun run-lols ()
  (abc 'foo 2 *print-pretty*)
  ;; This should fail
  ;;(abc% 'baz 'qux 'quux)
  (jmac1 'foo 'bar 'baz)
  (jmac2 'foo 'bar 'baz))
