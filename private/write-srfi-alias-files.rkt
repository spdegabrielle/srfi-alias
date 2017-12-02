(module write-srfi-alias-files mzscheme
  (require (lib "list.ss")
           (lib "etc.ss"))
  
  (define (module-template num module-name)
    (local ((define filename (get-srfi-filename num))
            (define num-string (format "~a" num)))
      `(module ,module-name (planet "mzlite.ss" ("dherman" "mzlite.plt" 1 0))
         (provide (all-from (lib ,filename "srfi")))
         (require (lib ,filename "srfi")))))
  
  
  
  (define (write-file num&module-name)
    (call-with-output-file
        (build-path (current-directory)
                    'up
                    (format "~a.ss" (second num&module-name)))
      (lambda (outp)
        (write (module-template (first num&module-name)
                                (second num&module-name))
               outp))
      'replace))
  
  
  ;; get-srfi-filename: number -> string
  (define (get-srfi-filename srfi-number)
    (let ([base-path (collection-path "srfi")])
      (let loop ([extensions '(".scm" ".ss")])
        (cond
          [(empty? extensions)
           (error 'get-file-name "Couldn't find path for SRFI ~a~n" srfi-number)]
          [(file-exists? (build-path base-path
                                     (string-append (number->string srfi-number)
                                                    (first extensions))))
           (string-append (number->string srfi-number)
                          (first extensions))]
          [else (loop (rest extensions))]))))
  
  
  
  (define (write-all-files)
    (for-each write-file srfis))
  
  (define srfis
    '((1 list)
      (2 and-let)
      (5 let)
      (7 program)
      (8 receive)
      (9 record)
      (13 string)
      (14 char-set)
      (17 set)
      (19 time)
      (25 array)
      (26 cut)
      (27 random-bits)
      (29 localization)
      (31 rec)
      (32 sort)
      (34 exception)
      (40 stream)
      (42 comprehensions)
      (43 vector-lib)
      (45 lazy)
      (48 format)
      (54 cat)
      (57 records)
      (59 vicinity)
      (67 compare)
      (69 hash)
      (71 letvalues)
      (78 check)
      (87 case))))
