(define square (lambda (a) (* a a)))
(define invert (lambda (a) (/ 1000 a)))
(define inc (lambda (a) (+ a 1)))



(define arg-max
    (lambda (func x)
        (cond
            ((null? (cdr x)) (car x))
            (else 
                (let ((max_num (func (car x))))
                    (cond 
                        ((< max_num (func (cadr x))) (arg-max func (cdr x)))
                        (else (arg-max func (cons (car x) (cddr x))))
                    )     
                )
            )
        )
    )
)
'(Question 1)
(arg-max square '(5 4 3 2 1))
(arg-max invert '(5 4 3 2 1))
(arg-max (lambda (x) (- 0 (square (- x 3)))) '(5 4 3 2 1))


#| Question 2
(arg-max square '(5 4 3 2 1))
(arg-max invert '(5 4 3 2 1))
(arg-max (lambda (x) (- 0 (square (- x 3)))) '(5 4 3 2 1))
|#
(define zip
    (lambda (x y z)
        (list x)
    )
)


(define zip2
    (lambda (x)
        (cond
            ((null? x) '())
            (else 
                (cons (car x) (zip2 (cdr x))))
        )
    )
)



#|Question 3
|#
(define size
    (lambda (x)
        (cond
            ((null? x) 0)
            (else (+ (size (cdr x)) 1))
        )
    )
)
(define unzip
    (lambda (x idx)
        (let (
                (check
                    (lambda (idx)
                        (cond
                            ((= idx 0) idx)
                            (else #f)
                        )
                    )
                )
            )
            (cond
                ((> idx (size x)) '())
                ((check idx) (car x))
                (else (unzip (cdr x) (- idx 1)))
            )
        )
    )
)
'(Question 3)
(unzip '( (1 2 3) (5 6 7) (5 9 2 )) 1)
(unzip '( (1 2 3) (5 6 7) (5 9 2 )) 0)



#|Question 4
(intersectlist '() '())
(intersectlist '(1 3) '(2 4))
(intersectlist '(1 2) '(2 4))
(intersectlist '(1 2 3) '(1 2 2 3 4))
|#

(define checkintersect
    (lambda (x y) 
        (cond
            ((null? y) #f)
            ((= x (car y)) y)
            (else (checkintersect x (cdr y)))
        )
    )
)
(define intersectlist
    (lambda (x y)
        (cond 
            ((or (null? x) (null? y)) '())
            (else
                (cond 
                    ((checkintersect (car x) y) 
                        (cons (car x) (intersectlist (cdr x) y)))
                    (else 
                        (intersectlist (cdr x) y))
                )
            )
        )   
    )
)
'(Question 4)
(intersectlist '() '())
(intersectlist '(1 3) '(2 4))
(intersectlist '(1 2) '(2 4))
(intersectlist '(1 2 3) '(1 2 2 3 4))
#|Question 5
(sortedmerge '(1 2 3) '(4 5 6))
(sortedmerge '(1 3 5) '(2 4 6))
(sortedmerge '(1 3 5) '())
|#
(define sortedmerge 
    (lambda (x y)
        (cond 
            ((and (null? x) (null? y)) '())
            ((null? x) y)
            ((null? y) x)
            (else 
                (cond
                    ((< (car x) (car y)) 
                        (cons (car x) (sortedmerge (cdr x) y)))
                    (else 
                        (cons (car y) (sortedmerge x (cdr y))))
                )
            )
        )
    )

)
'(Question 5)
(sortedmerge '(1 2 3) '(4 5 6))
(sortedmerge '(1 3 5) '(2 4 6))
(sortedmerge '(1 3 5) '())


#|Question 6
(interleave '(1 2 3) '(a b c))
(interleave '(1 2 3) '(a b c d e f))
(interleave '(1 2 3 4 5 6) '(a b c))
|#
(define interleave
    (lambda (x y)
        (cond 
            ((and (null? x) (null? y)) '())
            ((null? x) y)
            ((null? y) x)
            (else 
                (cons (car x) (interleave y (cdr x)))
            )
        )
    )
)
'(Question 6)
(interleave '(1 2 3) '(a b c))
(interleave '(1 2 3) '(a b c d e f))
(interleave '(1 2 3 4 5 6) '(a b c))


#|Question 7
(map2 '(1 2 3 4) '(2 3 4 5) (lambda (x) (> x 2)) inc)
|#
(define map2
    (lambda (x y punc func)
        (cond
            ((and (null? x) (null? y)) '())
            (else 
                (let (
                    (iter1 (car x)) (iter2 (car y))
                    )
                    (cond 
                        ((not (= (size x) (size y))) "The two lists are not of the same size.")
                        ((not (punc iter1)) 
                            (cons iter2 (map2 (cdr x) (cdr y) punc func)) )
                        (else 
                            (cons (func iter2) (map2 (cdr x) (cdr y) punc func)) )
                    )
                )
            )
        )
    )
)
'(Question 7)
(map2 '(1 2 3 4) '(2 3 4 5) (lambda (x) (> x 2)) inc)


#|Question 8a
(edge2adj '('(A B) '(B C) '(A C)) )
(find_adj '(A) '('(A B) '(B C) '(A C)))
(find_dst '(A) '('(A B) '(B C) '(A C)) )
(remove_duplicate (flatten '('(A B) '(B C) '(A C))))
|#
(define edge2adj
    (lambda (x)
        (cond
            ((null? x) '())
            (else 
                (let ((elem (remove_duplicate (flatten x)))
                    )
                    (find_adj elem x)
                )
                
            )
        )   
    )
)
(define find_adj
    (lambda (elem x)
        (cond
            ((null? elem) '())
            (else (cons (list (list (car elem)) (find_dst (list (car elem)) x)) (find_adj (cdr elem) x)
                 )
            )
        )
    )
)

(define find_dst
    (lambda (iter x)
        (cond
            ((null? x) '())
            ((equal? iter (list (caadar x))) 
                (cons (car (cdadar x)) (find_dst iter (cdr x))))
            (else
                (find_dst iter (cdr x)))
        )
    )
)

(define flatten
    (lambda (x)
        (cond
            ((null? x) '())
            (else 
                (append (cadar x) (flatten (cdr x))))
        )
    )
)

(define remove_duplicate
    (lambda (x)
        (cond
            ((null? x) '())
            ((member (car x) (cdr x)) (remove_duplicate (cdr x)))
            (else (cons (car x) (remove_duplicate (cdr x))))
        )
    )
)
'(question 8a)
(edge2adj '('(A B) '(B C) '(A C)) )
#|Question 8b
(adj2edge '('('(A) '(B C)) '('(B) '(C)) '('(C) '())))
(adj_helper '(A) '(B C))
|#
(define adj2edge
    (lambda (x)
        (cond
            ((null? x) '())
            (else
                (let ((iter (cadr (caadar x))))
                    (append (adj_helper iter (cadar (cdadar x))) (adj2edge (cdr x)))
                )
            )
        )
    )
)

(define adj_helper
    (lambda (iter x)
        (cond
            ((null? x) '())
            (else 
                (cons (append iter (list (car x))) (adj_helper iter (cdr x)))
            )
        )
    )
)
'(question 8b)
(adj2edge '('('(A) '(B C)) '('(B) '(C)) '('(C) '())))