(add-to-list 'org-publish-project-alist
             `("pages"
               :base-directory "~/src/blog/pages"
               :publishing-directory "~/src/blog/html/pages"
               :publishing-function org-html-publish-to-html
               :html-head-include-default-style nil
               :html-head ,(me/read-file "~/src/blog/templates/head.html")
               :html-preamble ,(me/read-file "~/src/blog/templates/preamble.html")
               :html-postamble ,(me/read-file "~/src/blog/templates/postamble.html")
               ))

(add-to-list 'org-publish-project-alist
             ("posts"
              :base-directory "~/src/blog/posts/"
              :publishing-directory "~/src/blog/html/"
              :publishing-function org-html-publish-to-html
              :html-head-include-default-style nil
              :html-head ,(me/read-file "~/src/blog/templates/head.html")
              :html-preamble ,(me/read-file "~/src/blog/templates/preamble.html")
              :html-postamble ,(me/read-file "~/src/blog/templates/postamble.html")
              :recursive t
              :with-date t
              :auto-sitemap t
              :sitemap-title "Latest posts"
              :sitemap-filename "index.org"
              ;; :sitemap-sort-files "chronologically"
              :sitemap-format-entry me/post-summary
              ;; :sitemap-function me/post-index
              ))

(add-to-list 'org-publish-project-alist
             ("blog" :components ("pages" "posts" ))
             )
