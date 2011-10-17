#lang scheme

(define *available-expenses-types*
  '(Epicerie Quincaillerie Bureau Vetement Resto Resto-diner Essence Unkown))
(define *expenses-db* (list))

(define (load-expenses-db)
  (set! *expenses-db* '())
  (call-with-input-file "/Users/sanctus/.r-expenses/expenses.sexp" #:mode 'binary
    (lambda (in) (for ([line (in-producer read eof in)])
                 (set! *expenses-db* (append *expenses-db* (list line)))))))

(define (total [expenses *expenses-db*] [current-total 0])
  (if (empty? expenses)
      current-total
      (total (rest expenses) (+ current-total (fourth (first expenses))))))

(define (total-for-category category [expenses *expenses-db*])
  (total (filter (lambda (expense) (eq? category (first expense))) expenses)))

(define (total-per-category)
  (map (lambda (x) `(,x ,(total-for-category x *expenses-db*)))
       *available-expenses-types*))

(define (total-expenses)
  (total *expenses-db*))


;;; Console GUI - Menu & User request
(define (choose-action action)
  (display action)
  (cond ((eq? action '1) (display (total)))
        ((eq? action '3) (display (total-per-category))))
  action)

(define (user-menu [requested 0])
  (display "\n--------------------------------------------\n")
  (display "| 1- Get total                             |\n")
  (display "| 2- Get categories listing                |\n")
  (display "| 3- Get total per category                |\n")
  (display "| 4- Get total for a category              |\n")
  (display "| Q- Quit                                  |\n")
  (display "--------------------------------------------\n")
  (set! requested (choose-action (read)))
  (if (or (eq? requested 'Q)
          (eq? requested 'q))
      #t
      (user-menu requested)))