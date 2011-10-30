#lang scheme
(require "../models/commands.rkt")

(provide user-menu)

;;; Console GUI - Menu & User request

(define (display-total-per-category data)
  (map (lambda (cat-info)
         (displayln (format "~s : ~s"
                            `,(first cat-info)
                            `,(second cat-info))))
       (data)))

(define (display-total-for-category)
  (display "For witch category : ")
  (let ((category (read)))
    (printf "Total for ~a : " category)
    (display (total-for-category category))))

(define (display-total-for-person)
  (display "For witch person : ")
  (let ((person (read)))
    (printf "Total for ~a : " person)
    (display (total-for-person person))))

(define (choose-action action)
  (cond ((eq? action '1) (display (total)))
        ((eq? action '2) (map (lambda (c) (displayln c)) (categories)))
        ((eq? action '3) (display-total-per-category total-per-category))
        ((eq? action '4) (display-total-for-category))
        ((eq? action '5) (display-total-for-person)))
  action)

(define (user-menu)
  (define requested-option #f)
  (display "\n--------------------------------------------\n")
  (display "| 1- Get total                             |\n")
  (display "| 2- Get categories listing                |\n")
  (display "| 3- Get total per category                |\n")
  (display "| 4- Get total for a category              |\n")
  (display "| 5- Get total for a person                |\n")
  (display "| Q- Quit                                  |\n")
  (display "--------------------------------------------\n")
  (set! requested-option (choose-action (read)))
  (if (not (or (equal? requested-option 'Q)
               (equal? requested-option 'q)))
      (user-menu)
      exit))
