#lang scheme

(require "commands.rkt")

;;; Console GUI - Menu & User request
(define (choose-action action)
  (cond ((eq? action '1) (display (total)))
        ((eq? action '3) (map (lambda (cat-info)
                                (displayln (format "~s : ~s"
                                                 `,(first cat-info)
                                                 `,(second cat-info))))
                                (total-per-category))))
  action)

(define (user-menu)
  (define requested-option #f)
  (display "\n--------------------------------------------\n")
  (display "| 1- Get total                             |\n")
  (display "| 2- Get categories listing                |\n")
  (display "| 3- Get total per category                |\n")
  (display "| 4- Get total for a category              |\n")
  (display "| Q- Quit                                  |\n")
  (display "--------------------------------------------\n")
  (set! requested-option (choose-action (read)))
  (if (not (or (equal? requested-option 'Q)
               (equal? requested-option 'q)))
      (user-menu)
      exit))

(user-menu)