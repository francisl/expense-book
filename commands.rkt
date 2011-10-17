#lang scheme

(require "bd.rkt")

(provide total)
(provide total-for-category)
(provide total-per-category)
(provide total-expenses)

(define (total [expenses (all)] [current-total 0])
  (if (empty? expenses)
      current-total
      (total (rest expenses) (+ current-total (fourth (first expenses))))))

(define (total-for-category category)
  (total (filter (lambda (expense) (eq? category (first expense))) (all))))

(define (total-per-category)
  (map (lambda (x) `(,x ,(total-for-category x)))
       (all-expenses)))

(define (total-expenses)
  (total (all)))
