;GUILE crap
;(use-syntax (ice-9 syncase))
;(define call/cc call-with-current-continuation)

(declare (uses syntax-case))

;AMB definition
(define amb-fail '*)

(define initialize-amb-fail
	(lambda ()
		(set! amb-fail
			(lambda () (error "amb tree exhausted!")))))

(initialize-amb-fail)

(define-syntax amb
	(syntax-rules ()
		(
			(amb "__internal" sk prev-amb-fail (alt))
			(call/cc
				(lambda (fk)
					(set! amb-fail
						(lambda ()
							(set! amb-fail prev-amb-fail)
							(fk 'fail)))
					(sk alt))))
		(
			(amb "__internal" sk prev-amb-fail (alt another-alt ...))
			(begin
				(call/cc
					(lambda (fk)
						(set! amb-fail
							(lambda ()
								(set! amb-fail prev-amb-fail)
								(fk 'fail)))
						(sk alt)))
				(amb "__internal" sk prev-amb-fail (another-alt ...))))
		(
			(amb alts ...)
			(let ( (prev-amb-fail amb-fail) )
				(call/cc
					(lambda (sk)
						(amb "__internal" sk prev-amb-fail (alts ...))
						(prev-amb-fail)))))))
							

(define amb-assert
	(lambda (pred)
		(if (not pred) (amb))))


