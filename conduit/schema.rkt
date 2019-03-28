#lang racket

(require sql)

;; https://www.sqlite.org/lang_createtable.html#rowid
;; sqlite automatic rowid columns
;; must be "integer" not "int"
;; for auto-assignment
;; ?? should they be #:not-null or not ??

(create-table
 #:if-not-exists
 tTags
 #:columns
 [tag text #:not-null])

(create-table
 #:if-not-exists
 tUsers
 #:columns
 [email text #:not-null]
 ;; token
 [username text #:not-null]
 [saltedHashedPassword blob #:not-null]
 [bio text #:not-null]
 [image blob] ;; ?? ;; null is ok
 #:constraints
 (primary-key email)
 (unique username))

(create-table
 #:if-not-exists
 tFollowing
 #:columns
 [follower text #:not-null]
 [followed text #:not-null]
 #:constraints
 (primary-key follower followed)
 (foreign-key follower #:references (tUsers email)
              #:on-delete #:cascade
              #:on-update #:cascade)
 (foreign-key followed #:references (tUsers email)
              #:on-delete #:cascade
              #:on-update #:cascade))

(create-table
 #:if-not-exists
 tArticles
 #:columns
 [articleId integer] ;; auto
 [title text #:not-null]
 [email text #:not-null]
 [description text #:not-null]
 [body text #:not-null]
 [createdAt integer #:not-null]
 [updatedAt integer #:not-null]
 ;; favorites slug tag
 #:constraints
 (primary-key articleId)
 (unique title)
 (constraint preventUpdateBeforeCreate
             (check (<= createdAt updatedAt)))
 (foreign-key email #:references tUsers
              #:on-delete #:cascade
              #:on-update #:cascade))
 
(create-table
 #:if-not-exists
 tSlugs
 #:columns
 [slug text #:not-null]
 [articleId integer]
 ;; "The slug also gets updated when the title is changed"
 ;; ... but in that case it should return a 404,
 ;; not (potentially) start pointing to some other article
 #:constraints
 (primary-key slug)
 (foreign-key articleId #:references tArticles
              #:on-delete #:set-null
              #:on-update #:set-null))
              
(create-table
 #:if-not-exists
 tArticleTags
 #:columns
 [tag text #:not-null]
 [articleId integer #:not-null]
 #:constraints
 (primary-key tag articleId)
 (foreign-key tag #:references tTags
              #:on-delete #:cascade
              #:on-update #:cascade)
 (foreign-key articleId #:references tArticles
              #:on-delete #:cascade
              #:on-update #:cascade))

(create-table
 #:if-not-exists
 tFavorites
 #:columns
 [email text #:not-null]
 [articleId integer #:not-null]
 #:constraints
 (primary-key email articleId)
 (foreign-key email #:references tUsers
              #:on-delete #:cascade
              #:on-update #:cascade)
 (foreign-key articleId #:references tArticles
              #:on-delete #:cascade
              #:on-update #:cascade))

(create-table
 #:if-not-exists
 tComments
 #:columns
 [commentId integer] ;; auto
 [article integer #:not-null]
 [email text #:not-null]
 [createdAt integer #:not-null]
 [updatedAt integer #:not-null]
 [body text #:not-null]
 #:constraints
 (primary-key commentId)
 (constraint preventUpdateBeforeCreate
             (check (<= createdAt updatedAt)))
 (foreign-key email #:references tUsers
              #:on-delete #:cascade
              #:on-update #:cascade)
 (foreign-key articleId #:references tArticles
              #:on-delete #:cascade
              #:on-update #:cascade))
 
