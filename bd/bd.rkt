#lang racket

(define *databases* (make-hash))

(define (db-table table-name)
  (hash-ref *databases* table-name))

;;; Query

(provide all)
(provide table-column)

(define (all table)
  (hash-ref (db-table table) 'data))

(define (table-column row column-name)
  (hash-ref row column-name))

;;; Database manipulation 
(define (database-register table-name load-function)
  (hash-set! *databases* table-name (make-hash))
  (hash-set! (db-table table-name) 'data (list))
  (hash-set! (db-table table-name) 'load-function load-function)
  (load-data table-name))

(define (load-data table-name)
  (define table (db-table table-name))
  (define database-name (format ".r-expenses/~a.sexp" table-name))
  (define set-table-function (hash-ref table 'load-function))
  (call-with-input-file (string-append
                         (path->string (find-system-path 'home-dir))
                         database-name)
    #:mode 'binary
    (lambda (data) (hash-set! (db-table table-name)
                          'data
                          (map (lambda (line) (set-table-function line))
                               (sequence->list (in-producer read eof data)))))))


;;; Person

(database-register 'person (lambda (line) line))
(define (person-default)
  (first (all 'person)))

;;; Expense

(define (set-data-expense line)
  (let ([data-hash (make-hash)])
    (hash-set! data-hash 'category (first line))
    (hash-set! data-hash 'store (second line))
    (hash-set! data-hash 'date (first (third line)))
    (hash-set! data-hash 'amount (fourth line))
    (if (equal? (length line) 5)
        (hash-set! data-hash 'persons (fifth line))
        (hash-set! data-hash 'persons (list (person-default))))
    data-hash))

(database-register 'expense set-data-expense)


;;; Category

(database-register 'category (lambda (line) line))


