(in-package #:portal)

#||
This file contains helpers.

||#


(defmacro ds (control-string &rest arguments)
  `(format nil ,control-string ,@arguments))

(defun alist->header (alist)
  "Return the string response header corresponding to ALIST."
  ;;to be replacec
  (-<>> (format nil "~a ~a ~a~a"
                (cdr (assoc :version alist))
                (cdr (assoc :code alist))
                (cdr (assoc :code-meaning alist))
                +crlf+)
    (reduce
     (lambda (header item)
       (if (member (car item) (list :version :code :code-meaning))
           header
           (format nil "~a~a: ~a~a"
                   header
                   (->> item
                     (car)
                     (symbol-name))
                   (cdr item)
                   +crlf+)))
     alist
     :initial-value)
    (concatenate 'string <> +crlf+)))

(defun sha1-base64 (string)
  (let ((sha1 (ironclad:make-digest 'ironclad:sha1))
        (bin-data (ironclad:ascii-string-to-byte-array string)))
    (ironclad:update-digest sha1 bin-data)
    (cl-base64:usb8-array-to-base64-string
     (ironclad:produce-digest sha1))))

(defun octets-to-string (octets)
  (babel:octets-to-string octets))

(defun string-to-octets (string)
  (babel:string-to-octets string))
  
