#lang scheme
(require "../bd/bd.rkt")

(provide total)
(provide total-for-category)
(provide total-per-category)
(provide total-expenses)
(provide total-for-person)
(provide categories)

(define (categories)
  (all 'category))

(define (total [expenses (all 'expense)] [current-total 0])
  (if (empty? expenses)
      current-total
      (total (rest expenses) (+ current-total (table-column (first expenses) 'amount)))))

(define (total-for-category category)
  (total (filter (lambda (expense)
                   (eq? category (table-column expense 'category)))
                 (all 'expense))))

(define (total-per-category)
  (map (lambda (x) `(,x ,(total-for-category x)))
       (all 'category)))

(define (total-expenses)
  (total (all 'expense)))


(define (total-for-person person)
  (total (filter (lambda (expense)
                   ((display expense)
                    (member person (table-column expense 'persons)))
                   #f)
                 (all 'expense))))
