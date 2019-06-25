;;; package --- org publish definitions for dwim blog

;;; Commentary:

;;; Code:

(add-to-list 'org-publish-project-alist
             `("pages"
               :base-directory "~/src/dwim/pages"
               :publishing-directory "~/src/dwim/html/pages"
               :publishing-function org-html-publish-to-html
               :html-head-include-default-style nil
               :html-head ,(me/read-file "~/src/dwim/templates/head.html")
               :html-preamble ,(me/read-file "~/src/dwim/templates/preamble.html")
               :html-postamble ,(me/read-file "~/src/dwim/templates/postamble.html")
               ))

(add-to-list 'org-publish-project-alist
             `("posts"
              :base-directory "~/src/dwim/posts/"
              :publishing-directory "~/src/dwim/html/"
              :publishing-function org-html-publish-to-html
              :html-head-include-default-style nil
              :html-head ,(me/read-file "~/src/dwim/templates/head.html")
              :html-preamble ,(me/read-file "~/src/dwim/templates/preamble.html")
              :html-postamble ,(me/read-file "~/src/dwim/templates/postamble.html")
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
             `("dwim" :components ("pages" "posts" ))
             )

(provide 'publish)
;;; publish.el ends here
