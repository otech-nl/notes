(defun me/read-file (filePath)
  "Return FILEPATH's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun me/find-regexp (regexp)
  "Returns first occurrence of REGEXP in current buffer"
  (goto-char (point-min))
  (search-forward-regexp regexp)
  (match-string 1))

(defun me/parse-post (entry project)
  "Reads blog file and processes it"
  (let* ((settings (cdr project))
         (post-filename (concat (plist-get settings :base-directory) entry)))
    (message "### entry: %s" post-filename)
    (with-temp-buffer
      (insert-file-contents post-filename)
      (list :filename post-filename
            :contents (buffer-string)
            :title (org-publish-find-title entry project)
            :date (org-publish-find-date entry project)
            :tags (split-string (me/find-regexp "^\\#\\+filetags:[ ]*\\(.+\\)$"))
            ))))

(defun me/post-summary (entry style project)
  "Default format for site map ENTRY, as a string.
ENTRY is a file name.  STYLE is the style of the sitemap.
PROJECT is the current project."
  (cond ((not (directory-name-p entry))
         (let ((data (me/parse-post entry project)))
           (format "[%s] [[file:%s][%s]] :%s:\n%s"
                   (format-time-string "%h %d, %Y" (plist-get data :date))
                   entry (plist-get data :title)
                   (mapconcat 'identity (plist-get data :tags) ":")
                   (plist-get data :contents))))))

(setq org-publish-project-alist
      `(("pages"
         :base-directory "~/src/blog/pages"
         :publishing-directory "~/src/blog/html/pages"
         :publishing-function org-html-publish-to-html
         :html-head-include-default-style nil
         :html-head ,(me/read-file "~/src/blog/templates/head.html")
         :html-preamble ,(me/read-file "~/src/blog/templates/preamble.html")
         :html-postamble ,(me/read-file "~/src/blog/templates/postamble.html")
         )
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
         )
        ("blog" :components ("pages" "posts" ))
        ))
