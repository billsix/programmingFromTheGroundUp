;GUILE crap
;(use-syntax (ice-9 syncase))
;(define call/cc call-with-current-continuation)

(declare (unit amb))

;AMB definition
(define amb-fail '*)

(define initialize-amb-fail
	(lambda x
		(set! amb-fail
			(if (null? x)
				(lambda () (error "amb tree exhausted!"))
				(car x)))))

(initialize-amb-fail)

(define amb
	(lambda alternatives
		(letrec 
			( (amb-internal 
					(lambda (sk alts)
						(if (null? alts)
							(prev-amb-fail)
							(begin
								(call/cc
									(lambda (fk)
										(set! amb-fail
											(lambda ()
												(set! amb-fail prev-amb-fail)
												(fk 'fail)))
										(sk (car alts))))
								(amb-internal sk (cdr alts))))))
				(prev-amb-fail amb-fail))
			(call/cc
				(lambda (sk)
					(amb-internal sk alternatives)
					(prev-amb-fail))))))

(define amb-assert
	(lambda (pred)
		(if (not pred) (amb))))

