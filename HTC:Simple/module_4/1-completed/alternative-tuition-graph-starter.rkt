(require 2htdp/image)
;; alternative-tuition-graph-starter.rkt

; 
; Consider the following alternative type comment for Eva's school tuition 
; information program. Note that this is just a single type, with no reference, 
; but it captures all the same information as the two types solution in the 
; videos.
; 
; (define-struct school (name tuition next))
; ;; School is one of:
; ;;  - false
; ;;  - (make-school String Natural School)
; ;; interp. an arbitrary number of schools, where for each school we have its
; ;;         name and its tuition in USD
; 
; (A) Confirm for yourself that this is a well-formed self-referential data 
;     definition.
; 
; (B) Complete the data definition making sure to define all the same examples as 
;     for ListOfSchool in the videos.
; 
; (C) Design the chart function that consumes School. Save yourself time by 
;     simply copying the tests over from the original version of chart.
; 
; (D) Compare the two versions of chart. Which do you prefer? Why?
; 


;; === Constants ===

;; bar graph
(define BAR-COLOR "lightblue")
(define BAR-WIDTH 30)
(define Y-SCALE 1/30)

;; fonts
(define FONT-COLOR "black")
(define FONT-SIZE 16)



;; (A)

;; School is a compound data in this case
;; Each school is made up of a String, a Natural and another School,
;;         which could be false or another make-school.

;; I think this is a complete self-referential data definition.
;;   - there are two cases without self reference, (school-nm) and (school ttn)
;;   - there is one case with self reference, (school-nxt)




;; (B)

(define-struct school (nm ttn nxt))
;; School is one of:
;;  - false
;;  - (make-school String Natural School)
;; interp. an arbitrary number of schools, where for each school we have its
;;         name <nm> and its tuition <ttn> in USD

;; examples of School
(define SCHOOL-1 false)
(define SCHOOL-2 (make-school "Cebu Normal University" 8000 false))
(define SCHOOL-3 (make-school "Saint Louis College" 15000
                              (make-school "Cebu Normal University" 8000 false)))
(define SCHOOL-4 (make-school "San Carlos University" 10000
                              (make-school "Saint Louis College" 15000
                                           (make-school "Cebu Normal University" 8000 false))))


(define (fn-for-school sc)
  (... (school-nm sc)                       ;String
       (school-ttn sc)                      ;Natural
       (fn-for-school (school-nxt sc))))    ;School, recursion

;; template rules used:
;;   - compound: 3 fields




;; (C)

;; School -> Image
;; produces an image with a black outline and the name of the school with a BAR-COLOR fill
;; examples/tests
(check-expect (bar SCHOOL-2)
              (overlay/align "middle" "bottom"
                             (rotate 90 (text (school-nm SCHOOL-2) FONT-SIZE FONT-COLOR))
                             (rectangle BAR-WIDTH (* Y-SCALE (school-ttn SCHOOL-2)) "outline" "black" )
                             (rectangle BAR-WIDTH (* Y-SCALE (school-ttn SCHOOL-2)) "solid" BAR-COLOR )))


;; stub
#;
(define (bar sc) (square 0 "solid" "white"))

(define (bar sc)
  (overlay/align "middle" "bottom"
                 (rotate 90 (text (school-nm sc) FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH (* Y-SCALE (school-ttn sc)) "outline" "black" )
                 (rectangle BAR-WIDTH (* Y-SCALE (school-ttn sc)) "solid" BAR-COLOR )))  





;; School -> Image
;; produce a bar graph with the schools in the x-axis and the (Y-SCALE * tuition) in y-axis,
;;           produces an empty image if the list is empty
;; examples/tests
(check-expect (bar-graph SCHOOL-1)
              (square 0 "solid" "white"))
(check-expect (bar-graph SCHOOL-2)
              (beside/align "bottom"
                            (overlay/align "middle" "bottom"
                                           (rotate 90 (text (school-nm SCHOOL-2) FONT-SIZE FONT-COLOR))
                                           (rectangle BAR-WIDTH (* Y-SCALE (school-ttn SCHOOL-2)) "outline" "black" )
                                           (rectangle BAR-WIDTH (* Y-SCALE (school-ttn SCHOOL-2)) "solid" BAR-COLOR ))
                            (square 0 "solid" "white")))


(check-expect (bar-graph SCHOOL-4)
              (beside/align "bottom"
                            (overlay/align "middle" "bottom"
                                           (rotate 90 (text "San Carlos University" FONT-SIZE FONT-COLOR))
                                           (rectangle BAR-WIDTH (* Y-SCALE 10000) "outline" "black" )
                                           (rectangle BAR-WIDTH (* Y-SCALE 10000) "solid" BAR-COLOR ))

                            (overlay/align "middle" "bottom"
                                           (rotate 90 (text "Saint Louis College" FONT-SIZE FONT-COLOR))
                                           (rectangle BAR-WIDTH (* Y-SCALE 15000) "outline" "black" )
                                           (rectangle BAR-WIDTH (* Y-SCALE 15000) "solid" BAR-COLOR ))

                            (overlay/align "middle" "bottom"
                                           (rotate 90 (text "Cebu Normal University" FONT-SIZE FONT-COLOR))
                                           (rectangle BAR-WIDTH (* Y-SCALE 8000) "outline" "black" )
                                           (rectangle BAR-WIDTH (* Y-SCALE 8000) "solid" BAR-COLOR ))
                            (square 0 "solid" "white")))


;; stub
#;
(define (bar-graph sc) (square 0 "solid" "white"))


(define (bar-graph sc)
  (if (false? sc)  
      (square 0 "solid" "white")                        ;base case
      (beside/align "bottom"
                    (bar sc)                            ;helper function
                    (bar-graph (school-nxt sc)))))      ;recursion                 
                