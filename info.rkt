#lang info

(define collection "realworld")
(define pkg-desc
  "Example RealWorld backend implementation (https://realworld.io)")
(define version "0.0")
(define pkg-authors '(philip))

(define scribblings
  '(("scribblings/realworld.scrbl" ())))

(define deps
  '("base"
    "db"
    "sql"
    "web-server-lib"))
(define build-deps
  '("scribble-lib"
    "draw-lib"
    "pict-lib"
    "rsvg"
    "scribble"
    "racket-doc"
    "rackunit-lib"))
