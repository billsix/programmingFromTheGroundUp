<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY dbstyle-print SYSTEM "/usr/share/sgml/docbook/dsssl-stylesheets/print/docbook.dsl" CDATA DSSSL>
<!ENTITY dbstyle-html SYSTEM "/usr/share/sgml/docbook/dsssl-stylesheets/html/docbook.dsl" CDATA DSSSL>
]>

<style-sheet>
<!--

Copyright 2002 Jonathan Bartlett

Permission is granted to copy, distribute and/or modify this
document under the terms of the GNU Free Documentation License,
Version 1.1 or any later version published by the Free Software
Foundation; with no Invariant Sections, with no Front-Cover Texts,
and with no Back-Cover Texts.  A copy of the license is included in fdl.xml

-->

<style-specification use="docbook-html" id="html">
<style-specification-body>

(define %footnote-ulinks% #f)
(define show-comments #f)

</style-specification-body>
</style-specification>
<style-specification use="docbook-print" id="printdraft">
<style-specification-body>

;(define %page-width% 8.25in)
;(define %page-height% 10.75in)
(define %footnote-ulinks% #f)
;(define %two-side% #t)
(define tex-backend #t)
(define bop-footnotes #t)
(define show-comments #t)
;(define %visual-acuity% "presbyopic")
(define %body-start-indent% 0pt)
(define %hsize-bump-factor% 1.1)
(define (toc-depth nd)
	(if (string=? (gi nd) (normalize "book"))
		2
		1
	)
)
(define ($generate-book-lot-list$)
  (list)
)


</style-specification-body>
</style-specification>
<style-specification use="docbook-print" id="print">
<style-specification-body>

(define %page-width% 7.5in)
(define %page-height% 9.25in)
(define %footnote-ulinks% #f)
(define %two-side% #t)
(define tex-backend #t)
(define bop-footnotes #t)
(define show-comments #f)
(define %visual-acuity% "presbyopic")
(define %body-start-indent% 0pt)
(define %hsize-bump-factor% 1.1)

(define (toc-depth nd)
	(if (string=? (gi nd) (normalize "book"))
		2
		1
	)
)
(define ($generate-book-lot-list$)
  (list)
)

</style-specification-body>
</style-specification>
<external-specification id="docbook-print" document="dbstyle-print">
<external-specification id="docbook-html" document="dbstyle-html">
</style-sheet>
