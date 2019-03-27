#lang racket

(require rsvg
         pict
         racket/draw
         file/convertible
         racket/runtime-path)

(define-runtime-path upstream-logo.png
  "upstream-logo.png")
(define-runtime-path logo.svg
  "logo.svg")
(define-runtime-path logo.png
  "../logo.png")

(module+ main
  (void
   (call-with-output-file* logo.png
     #:exists 'replace
     (λ (out) (write-bytes png-bytes out)))))

(define upstream
  (bitmap (read-bitmap upstream-logo.png)))

(define size
  (pict-height upstream))

(define racket
  ;; FIXME the margins aren't quite right here
  (scale-to-fit (svg-file->pict logo.svg)
                (blank size size)
                #:mode 'inset))

(define logo
  (hc-append racket
             (inset/clip upstream (- size) 0 0 0)))

(define png-bytes
  (convert logo 'png-bytes))
