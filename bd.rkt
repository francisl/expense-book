#lang scheme

(provide all)
(provide all-expenses)

(define *available-expenses-types*
  '(Epicerie Quincaillerie Bureau Vetement Resto Resto-diner Essence Unkown))
(define *expenses-db* (list))

(define (load-expenses-db)
  (set! *expenses-db* '())
  (display "\nloading database ..")
  (call-with-input-file "/Users/sanctus/.r-expenses/expenses.sexp" #:mode 'binary
    (lambda (in) (for ([line (in-producer read eof in)])
                 (set! *expenses-db* (append *expenses-db* (list line)))))))

(define (all)
  *expenses-db*)

(define (all-expenses)
  *available-expenses-types*)

(load-expenses-db)
