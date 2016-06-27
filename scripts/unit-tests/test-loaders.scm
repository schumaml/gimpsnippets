(define (try-load-by-extension handler)
  (let ((matches '#("" "")))
    (cond ((re-match "file-([^-]+)-load" handler matches)
	   (let ((badfilename  (string-append "idonotexist." (re-match-nth handler matches 1))))
	     
	     ; try to load the file, we expect this to fail...
	     (catch (gimp-file-load RUN-NONINTERACTIVE badfilename badfilename)
		    (gimp-message (string-append "Expected fail: " filename))) 
	     ; try to load the file, we do NOT expect this to fail...
	   )
	  )
    )
  )
)

(define (try-load-by-handler handler)
  (cond ((re-match "^file-[^-]+-load$" handler)
	 (let 
	     ((badfilename  (string-append "idonotexist.file")))
	      (define tempfunc (lambda x (apply gimp-proc-db-call (cons handler x))))
	     
;try to load the file, we expect this to fail...
	   (catch (tempfunc RUN-NONINTERACTIVE badfilename badfilename)
		  (gimp-message (string-append "Expected fail: " filename))) 
; try to load the file, we do NOT expect this to fail...
;	     (catch (gimp-file-load RUN-NONINTERACTIVE goodfilename goodfilename)
;		   (gimp-message (string-append "UNEXPECTED fail: " filename))9
	   )
	 )
	)
  )

(define (my-cel-load)
  (gimp-message "foo-cel :)")"
  (car (file-cel-load RUN-INTERACTIVE "foo.cel" "foo.cel" "blubb.pal"))
)



(define (script-fu-test-missing-files path)
  (let 
      ((loadHandlers (vector->list (cadr (gimp-procedural-db-query ".*-load" "" "" "" "" "" "")))))
;    (map try-load-by-extension loadHandlers)
    (map try-load-by-handler   loadHandlers)
;    (map gimp-message loadHandlers)
))

(script-fu-register "script-fu-test-missing-files"
  _"_Missing Files..."
  "Try to load a non-exisitng files of each known file type and check how scripts do behave."
  "Michael Schumacher"
  "Michael Schumacher"
  "2007"
  ""
  SF-DIRNAME    "Test images"   "./missing-files/"
)

(script-fu-menu-register "script-fu-test-missing-files"
                         "<Toolbox>/Xtns/Languages/Script-Fu/Tests/")

