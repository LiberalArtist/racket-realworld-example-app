#lang racket

(require web-server/dispatch
         web-server/http
         syntax/parse/define)

(define-simple-macro (define/contract/todo (name:id formal ...) c:expr)
  (define/contract (name formal ...)
    c
    (error 'name "not yet implemented")))
  
(define/contract/todo (get-tags req)
  (-> request? response?))

(define/contract/todo (authenticate req)
  (-> request? response?))

(define/contract/todo (register req)
   (-> request? response?))

(define/contract/todo (get-current-user req)
  (-> request? response?))

(define/contract/todo (update-user req)
  (-> request? response?))

(define/contract/todo (get-profile req username)
  (-> request? string? response?))

(define/contract/todo (follow-user req username)
  (-> request? string? response?))

(define/contract/todo (unfollow-user req username)
  (-> request? string? response?))

(define/contract/todo (list-articles req)
  (-> request? response?))

(define/contract/todo (feed-articles req)
  (-> request? response?))

(define/contract/todo (get-article req slug)
  (-> request? string? response?))

(define/contract/todo (create-article req)
  (-> request? response?))

(define/contract/todo (update-article req slug)
  (-> request? string? response?))

(define/contract/todo (delete-article req slug)
  (-> request? string? response?))

(define/contract/todo (favorite-article req slug)
  (-> request? string? response?))

(define/contract/todo (unfavorite-article req slug)
  (-> request? string? response?))

(define/contract/todo (add-comment-to-article req slug)
  (-> request? string? response?))

(define/contract/todo (get-comments-from-article req slug)
  (-> request? string? response?))

(define/contract/todo (delete-comment-from-article req slug comment-id)
  (-> request? string? natural-number/c response?))

(dispatch-rules
 [("api" "tags")
  get-tags]
 ;;;;;;;;;;;;;;;;;;;;
 [("api" "users" "login")
  #:method "post"
  authenticate]
 [("api" "users")
  #:method "post"
  register]
 [("api" "user")
  get-current-user]
 [("api" "user")
  #:method "put"
  update-user]
 ;;;;;;;;;;;;;;;;;;;;
 [("api" "profiles" (string-arg))
  get-profile]
 [("api" "profiles" (string-arg) "follow")
  #:method "post"
  follow-user]
 [("api" "profiles" (string-arg) "follow")
  #:method "delete"
  unfollow-user]
 ;;;;;;;;;;;;;;;;;;;;
 [("api" "articles")
  list-articles]
 [("api" "articles" "feed")
  feed-articles]
 [("api" "articles" (string-arg))
  get-article]
 [("api" "articles")
  #:method "post"
  create-article]
 [("api" "articles" (string-arg))
  #:method "put"
  update-article]
 [("api" "articles" (string-arg))
  #:method "delete"
  delete-article]
 [("api" "articles" (string-arg) "comments")
  #:method "post"
  add-comment-to-article]
 [("api" "articles" (string-arg) "comments")
  get-comments-from-article]
 [("api" "articles" (string-arg) "comments" (integer-arg))
  #:method "delete"
  delete-comment-from-article]
 [("api" "articles" (string-arg) "favorite")
  #:method "post"
  favorite-article]
 [("api" "articles" (string-arg) "favorite")
  #:method "delete"
  unfavorite-article])
  