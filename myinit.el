
;; (use-package org-bullets    ;; org-mode 美化
  ;;   :ensure t
  ;;   :config
  ;;   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

  ;; (setq ido-enable-flex-matching t)  ;; NB匹配, 被swiper/ivy/counsel代替
  ;; (setq ido-everywhere t)            ;; 打开文件时展示列表
  ;; (ido-mode 1)

;;;; flashes the cursor's line when you scroll
;;  (use-package beacon
;;    :ensure t
;;    :config
;;    (beacon-mode 1)
;;    ;; (setq beacon-color "#666600")
;;    )

(defvar mypackages
  '(session
    dashboard
    projectile
    counsel-projectile
    neotree
    emmet-mode
    highlight-parentheses
  ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      mypackages)

(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories")


  (use-package try
    :ensure t)


  (defun load-if-exists (f)
    "load the elisp file only if it exists and is readable"
    (if (file-readable-p f)
        (load-file f)))

  (load-if-exists "~/.emacs.d/myfiles/auto-save.el")
  (load-if-exists "~/.emacs.d/myfiles/tmp-test.el")

(global-set-key (kbd "\e\em")
              (lambda () (interactive) (find-file "~/.emacs.d/myinit.org")))

(global-set-key (kbd "\e\es")
              (lambda () (interactive) (find-file "~/scheduled/scheduled.org")))

(global-set-key (kbd "\e\ep")
              (lambda () (interactive) (find-file "/var/www/")))

(global-set-key (kbd "\e\ew")
              (lambda () (interactive) (find-file "~/wiki/")))

(global-set-key (kbd "\e\ei")
              (lambda () (interactive) (find-file "~/mine/")))

(global-set-key (kbd "\e\ee")
              (lambda () (interactive) (find-file "~/org/note.org")))

;; 移除旧的org-mode 绑定
(define-key org-mode-map (kbd "C-k") nil)
(define-key org-mode-map (kbd "C-M-j") nil)
(define-key org-mode-map (kbd "C-j") nil)
(define-key org-mode-map (kbd "C-<tab>") nil)
(define-key org-mode-map (kbd "C-v") nil)
(define-key org-mode-map (kbd "M-v") nil)
(define-key org-mode-map (kbd "S-<return>") nil)

;; c-mode
;;(define-key c-mode-map (kbd "M-j") nil)

;; 重新定义

(global-set-key (kbd "C-w") 'forward-char)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "C-<tab>") 'previous-buffer)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-z") 'undo-tree-undo)

;; 新建一行
(defun my-newline nil  
  "open new line belowe current line"  
  (interactive)  
  (end-of-line)  
  (newline))
(global-set-key (kbd "S-<return>") 'my-newline)

;; 下一个单词
(defun my-next-word nil  
  "my next word"  
  (interactive)  
  (forward-word)  
  (forward-word)
  (backward-word)
  )
(global-set-key (kbd "M-w") 'my-next-word)

;; 复制单词
(defun my-copy-word nil  
  "my copy word"
  (interactive)  
  (forward-word)  
  (backward-word)
  (push-mark)
  (forward-word)  
  (kill-ring-save (region-beginning)(region-end))
)
(global-set-key (kbd "C-M-w") 'my-copy-word)

;; M-x package-install dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-items '((recents  . 5)
                        ))

(global-set-key (kbd "\e\ed") 'dashboard-refresh-buffer)


;; n next line ， p previous line。
;; SPC or RET or TAB Open current item if it is a file. Fold/Unfold current item if it is a directory.
;; g Refresh
;; A Maximize/Minimize the NeoTree Window
;; H Toggle display hidden files
;; C-c C-n Create a file or create a directory if filename ends with a ‘/’
;; C-c C-d Delete a file or a directory.
;; C-c C-r Rename a file or a directory.
;; C-c C-c Change the root directory.
;; C-c C-p Copy a file or a directory.
(require 'neotree)
  (global-set-key [f9] 'neotree-toggle)
  (setq neo-theme 'arrow)
  (setq counsel-projectile-switch-project 'neotree-projectile-action)

(setq inhibit-startup-message t)

  (fset 'yes-or-no-p 'y-or-n-p)

  (global-auto-revert-mode 1)

  (global-set-key (kbd "<f5>") 'revert-buffer)

  (server-mode 1)

  
  ;; 打开最近文件
  (require 'recentf)
  (recentf-mode 1)
  (setq recentf-max-menu-item 20)
  (global-set-key (kbd "\e\er") 'recentf-open-files)

  (setq initial-frame-alist (quote ((fullscreen . maximized))))  ;; 默认全屏

;; 
;; (if (display-graphic-p)
;;     (progn
;;       (setq initial-frame-alist
;;             '(
;;               (width . 106) ; chars
;;               (height . 60) ; lines
;;               ;;
;;               ))
;; 
;;       (setq default-frame-alist
;;             '(
;;               (width . 106)
;;               (height . 60)
;;               ;;
;;               ))))

;; 启动回到原来的界面
;;(require 'session)
;;(add-hook 'after-init-hook 'session-initialize)
;;(desktop-save-mode t)

;; 自动保存
;;(add-to-list
;; 'load-path 
;; (expand-file-name "3rds" user-emacs-directory)) ;把3rds目录加到加载目录中

(require 'auto-save)            ;; 加载自动保存模块
(auto-save-enable)              ;; 开启自动保存功能
(setq auto-save-slient t)       ;; 自动保存的时候静悄悄的

(setq auto-save-default nil)    ;;不生成##文件

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; 重置文字段落宽度
;; Add left and right margins, when file is markdown or text.
(defun center-window (window) ""
  (let* ((current-extension (file-name-extension (or (buffer-file-name) "foo.unknown")))
         (max-text-width 30)
         (margin (max 0 (/ (- (window-width window) max-text-width) 2))))
    (if (and (not (string= current-extension "org"))
             (not (string= current-extension "txt")))
        ;; Do nothing if this isn't an .md or .txt file.
        ()
      (set-window-margins window margin margin))))
;; Adjust margins of all windows.
(defun center-windows () ""
  (walk-windows (lambda (window) (center-window window)) nil 1))
;; Listen to window changes.
(add-hook 'window-configuration-change-hook 'center-windows)

;; 去掉换行的箭头
(global-visual-line-mode 1)


  (use-package atom-one-dark-theme
    :ensure t
    :config (load-theme 'atom-one-dark t))

  (menu-bar-mode -1)
  (global-set-key [f10] 'menu-bar-mode)         ;;打开/关闭菜单  

  (tool-bar-mode -1)

  (scroll-bar-mode -1)    ;;滚动条
  
  ;; 设置 M-x customize-group RET yascroll RET 
  (load-if-exists "~/.emacs.d/myfiles/yascroll-el/yascroll.el")
  (global-yascroll-bar-mode t)

  (global-hl-line-mode t)

  (global-linum-mode 1)           ;; 显示行号

  (setq ring-bell-function 'ignore) ;; 去掉提示音

  ;;(set-face-attribute 'default nil :height 146)  ;; 字体大小
  (setq-default line-spacing 6)                  ;; 行高

  ;;;设置标题栏显示文件的完整路径名  
  ;; (setq frame-title-format  
  ;;  '("%S" (buffer-file-name "%f"  
  ;;   (dired-directory dired-directory "%b"))))


;; 红色渐变显示括号
(require 'highlight-parentheses)

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))

(global-highlight-parentheses-mode t)

;; 
(setq linum-format "%d ")
(setq linum-format "%4d \u2502 ")

(defalias 'list-buffers 'ibuffer)              ;; 一直在找的buffer管理

(windmove-default-keybindings)                 ;; S-down window间方向键移动

(use-package ace-window                        ;; 多窗口C-x o 数字切换
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0))))) 
    ))


;; it looks like counsel is a requirement for swiper
(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))  ;;yank 的NB扩展

;; 浏览器C-c, emacs C-w后,將浏览器剪贴板放入M-y
(setq save-interprogram-paste-before-kill t)

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))



(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    ))



(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

;; search in files: ag-files
;; install tricks: sudo apt install 
(use-package ag
   :ensure t)

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir))
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode))

(use-package counsel-projectile
  :config
  (counsel-projectile-on))

(use-package org-projectile
  :bind (("C-c n p" . org-projectile:project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (progn
    (setq org-projectile:projects-file 
          "~/org-my/projects.org")
    (setq org-agenda-files (append org-agenda-files (org-projectile:todo-files)))
    (add-to-list 'org-capture-templates (org-projectile:project-todo-entry "p")))
  :ensure t)

(use-package magit
  :config
  (setq magit-completing-read-function 'ivy-completing-read))

(use-package magit-popup)

;;  (use-package which-key
;;    :ensure t 
;;    :config
;;    (which-key-mode))

  (use-package auto-complete        ;; 已输过单词自动完成
    :ensure t
    :init
    (progn
      (ac-config-default)
      (global-auto-complete-mode t)
      ))

  ;; visualize tree: C-x u
  ;; undo: C-/ redo: C-?
  (use-package undo-tree
    :ensure t
    :init
    (global-undo-tree-mode))

;;  (use-package hungry-delete
;;    :ensure t
;;    :config
;;    (global-hungry-delete-mode))

  (use-package expand-region
    :ensure t
    :config 
    (global-set-key (kbd "C-o") 'er/expand-region))

  (delete-selection-mode 1)          ;; 选中后输入会替换掉你选中部分
  
  (require 'dired-x)                 ;; C-x C-j 进入当前文件夹

  (setq x-select-enable-clipboard t) ;;支持emacs和外部程序的粘贴

  (setq default-tab-width 4)
  (setq-default indent-tabs-mode nil) ; tab 改为插入空格
  (setq c-basic-offset 4) ; c c++ 缩进4个空格
  (setq c-default-style "linux"); 没有这个 { } 就会瞎搞

;; 复制选区或复制一行
(global-set-key "\M-k"
(lambda ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
      (region-end))
    (progn
     (kill-ring-save (line-beginning-position)
     (line-end-position))
     (message "copied line")))))

;; 复制新的一行
(defun my-new-line nil  
  "my function copied and pasted line"  
  (interactive)  
  (kill-ring-save (line-beginning-position)
  (line-end-position))
  (end-of-line)  
  (newline)
  (yank)
  (message "copied and pasted line"))
(global-set-key (kbd "C-M-k") 'my-new-line)

  ;; 删除行内光标前文字
(defun my-delete-line-left nil  
  "my delete line left"  
  (interactive)  
  (push-mark)
  (back-to-indentation)
  (kill-region (point) (mark))
  (message "deleted line left"))
(global-set-key (kbd "M-<backspace>") 'my-delete-line-left)

;; 删除行内光标后文字
(defun my-delete-line-right nil  
  "my delete line right"  
  (interactive)  
  (kill-line)
  (message "deleted line right"))
(global-set-key (kbd "M-<delete>") 'my-delete-line-right)

;; 剪贴选区或剪贴一行
(global-set-key "\C-k"
(lambda ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
      (region-end))
  (progn
     (kill-whole-line 1)
     (message "killed line")))))

;; 上移一行
(defun my-up-line nil  
  "my up line"  
  (interactive)  
  (kill-whole-line 1)
  (beginning-of-line 0)
  (yank)
  (beginning-of-line 0)
  (end-of-line)
  (message "up line"))
(global-set-key (kbd "C-<up>") 'my-up-line)

;; 下移一行
(defun my-down-line nil  
  "my down line"  
  (interactive)  
  (kill-whole-line 1)
  (beginning-of-line 2)
  (yank)
  (beginning-of-line 0)
  (end-of-line)
  (message "down line"))
(global-set-key (kbd "C-<down>") 'my-down-line)

;; % 括号间跳转
(defun ar-match-paren (&optional arg)
  "Go to the matching brace, bracket or parenthesis if on its counterpart."
  (interactive "P")
  (if arg
      (self-insert-command (if (numberp arg) arg 1))
    (cond ((eq 4 (car (syntax-after (point))))
       (forward-sexp)
       (forward-char -1))
      ((eq 5 (car (syntax-after (point))))
       (forward-char 1)
       (backward-sexp))
      (t (self-insert-command 1)))))
(global-set-key [(%)] 'ar-match-paren)

;; 隐藏打开函数
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)))

(use-package ox-reveal
  :ensure ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(use-package htmlize
  :ensure t)

;;  (use-package flycheck
;;    :ensure t
;;    :init
;;    (global-flycheck-mode t))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(global-set-key (kbd "C-c c")
                'org-capture)

(setq org-todo-keyword-faces '(
                               ("TODO" . (:foreground "steelBlue" :weight normal)) 
                               ("DONE" . (:foreground "darkSlateGray" :weight normal)) ))

(defadvice org-capture-finalize 
    (after delete-capture-frame activate)  
  "Advise capture-finalize to close the frame"  
  (if (equal "capture" (frame-parameter nil 'name))  
      (delete-frame)))

(defadvice org-capture-destroy 
    (after delete-capture-frame activate)  
  "Advise capture-destroy to close the frame"  
  (if (equal "capture" (frame-parameter nil 'name))  
      (delete-frame)))  

(use-package noflet
  :ensure t )
(defun make-capture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")))
  (select-frame-by-name "capture")
  (delete-other-windows)
  (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
    (org-capture)))

(global-set-key (kbd "C-x C-b") 'ibuffer)
 (setq ibuffer-saved-filter-groups
       (quote (("default"
                ("dired" (mode . dired-mode))
                ("org" (mode . org-mode))
                ("emacs" (or
                          (name . "^\\*scratch\\*$")
                          (name . "^\\*Messages\\*$")
                          (name . "^\\*Backtrace\\*$")
                          (name . "^\\*dashboard\\*$")))
                ))))
 (add-hook 'ibuffer-mode-hook
           (lambda ()
             (ibuffer-switch-to-saved-filter-groups "default")))

;;;; http://tkf.github.io/emacs-jedi/latest/#configuration
  ;;;; m-x package-install RET jedi RET
  ;;;; M-x jedi:install-server RET
  ;;;; 上一步安装时,不确定是否安装成功
;;  (use-package jedi    ;; Python auto-completion
;;    :ensure t
;;    :init
;;    (add-hook 'python-mode-hook 'jedi:setup)
;;    (add-hook 'python-mode-hook 'jedi:ac-setup))

;;  (use-package elpy
;;    :ensure t
;;    :config 
;;    (elpy-enable))
;;;; 经测试,菜单加VirturalEnvs在其他如c环境也有,不需要

;; wrap tag: C-c C-e w
;; commit M-;
;; C-c C-n：放在HTML标签上，在标签间跳转。
;; C-c C-f：放在HTML标签上，在标签折叠。
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
        '(("django"    . "\\.html\\'")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-quoting t))


;; a：a+href
;; #q：div+id(q)
;; .x：div+class(x)
;; #q.x：div+id(q)+class(x)
(require 'emmet-mode)
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)

(add-to-list 'load-path "~/.emacs.d/myfiles/php-mode")
(require 'php-mode)
(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; 自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;; 语法高亮
(setq org-src-fontify-natively t)
;; 转化为markdown 导出markdown 
;; M-x org-md-export-to-markdown
;; C-c C-e m m
(eval-after-load "org"
  '(require 'ox-md nil t))
;; 图片宽度
(setq org-image-actual-width '(600))

(add-to-list 'org-structure-template-alist
    '("lisp" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC" "<src lang=\"R\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
    '("php" "#+BEGIN_SRC php\n?\n#+END_SRC" "<src lang=\"R\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
    '("js" "#+BEGIN_SRC js\n?\n#+END_SRC" "<src lang=\"R\">\n?\n</src>"))

(defun my-open-terminal ()
  "my-open-terminal"
  (interactive)
  (shell-command "gnome-terminal"))

(global-set-key (kbd "M-z") 'my-open-terminal)

;;(add-to-list 'load-path "~/.emacs.d/myfiles/evil")
;;(require 'evil)
;;(evil-mode -1)

;;;;(setq evil-toggle-key "")   ; remove default evil-toggle-key C-z, manually setup later
;;(setq evil-want-C-i-jump nil) ; don't bind [tab] to evil-jump-forward

;; remove all keybindings from insert-state keymap, use emacs-state when editing
;;(setcdr evil-insert-state-map nil)
    
;; ESC to switch back normal-state
;;(define-key evil-insert-state-map [escape] 'evil-normal-state)

;;;;(load-if-exists "~/.emacs.d/cnfonts/cnfonts-pkg.el")
;;(load-if-exists "~/.emacs.d/cnfonts/cnfonts-ui.el")
;;(load-if-exists "~/.emacs.d/cnfonts/cnfonts.el")
;;(require 'cnfonts)
;;;; 让 cnfonts 随着 Emacs 自动生效。
;;(cnfonts-enable)
;;;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;;(cnfonts-set-spacemacs-fallback-fonts)

;;编辑字体及大小
;;M-x cnfonts-edit-profile-without-ui  然后C-c C-c测试
;;| cnfonts-increase-fontsize | 增大字号     |
;;| cnfonts-decrease-fontsize | 减小字号     |



;;中文与外文字体设置
(defun set-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil :font
                      (format   "%s:pixelsize=%d"  english english-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family chinese :size chinese-size))))

(set-font   "WenQuanYi Zen Hei Mono" "WenQuanYi Zen Hei Mono" 17 17)

;; C-c C-e P x     (org-publish)
;; Prompt for a specific project and publish all files that belong to it. 
;; C-c C-e P p     (org-publish-current-project)
;; Publish the project containing the current file. 
;; C-c C-e P f     (org-publish-current-file)
;; Publish only the current file. 
;; C-c C-e P a     (org-publish-all)
;; Publish every project.

;; 另一种生成html的方式
;; M-x htmlize-buffer
;; https://github.com/hniksic/emacs-htmlize
(require 'ox-publish)

(org-publish-all )
;; http://orgmode.org/manual/Publishing-options.html#Publishing-options
(setq org-html-postamble nil)        ;; 不显示创建日期
(setq org-export-with-creator nil)   ;; 不显示emacs版本
(setq org-html-validation-link nil)  ;; 不显示文章底部的Validate
;; org转html换行 http://orgmode.org/manual/Export-settings.html#Export-settings
(setq org-export-preserve-breaks t) 
(setq org-html-doctype "html5")      ;; 设置导出为HTML5格式, 默认貌似是XML.
(setq org-html-head-include-default-style nil)    ;;不显示默认的css
(setq org-html-head-include-scripts nil)          ;;不显示默认的js

 
(setq org-publish-project-alist
      '(

       ;; ... add all the components here (see below)...
("scheduled"
 :html-indent ""
 :html-link-home "/scheduled/"
 :html-link-up "../"
 :html-head "
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1\">
<link rel='stylesheet' media='screen and (max-width: 1100px)' href='/scheduled/src/css/doc-mobile.css' type='text/css'/>
<link rel='stylesheet' media='screen and (min-width: 1100px)' href='/scheduled/src/css/doc-pc.css' type='text/css'/>
"
 :base-directory "~/scheduled/"
 :base-extension "org"
 :publishing-directory "/var/www/html/scheduled/"
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 4             ; Just the default for this project.
 :auto-preamble t
 :author "Bear Arpher"
 :email "bearpher@gmail.com"
 :auto-sitemap t                ; Generate sitemap.org automagically...
 :sitemap-filename "index.org"  ; ... call it sitemap.org (it's the default)...
 :sitemap-title "排程"          ; ... with title 'Sitemap'.
 :sitemap-sort-files anti-chronologically
 :sitemap-file-entry-format "%d %t"  ; "%d %t"时间+标题构成索引index.html
;; :with-author nil             ;; 不显示作者
 :language "zh-CN"
 )

("blog" :components ("blog-notes" "blog-static"))

("time"
 :html-link-home "/time/"
 :html-link-up "../"
 :html-head "<link rel=\"stylesheet\"
                         href=\"/time/src/css/gongzhitaao2.css\"
                         type=\"text/css\"/>"
 :base-directory "~/time/"
 :base-extension "org"
 :publishing-directory "/var/www/html/time/"
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 4             ; Just the default for this project.
 :auto-preamble t
 :author "Bear Arpher"
 :email "bearpher@hotmail.com"
 :auto-sitemap t                ; Generate sitemap.org automagically...
 :sitemap-filename "index.org"  ; ... call it sitemap.org (it's the default)...
 :sitemap-title "日历"          ; ... with title 'Sitemap'.
 :sitemap-sort-files anti-chronologically
 :sitemap-file-entry-format "%t"
;; :with-author nil             ;; 不显示作者
 :language "zh-CN"
 )

("blog-notes"
 :html-link-home "/blog/"
 :html-link-up "../"
 :html-head "<link rel=\"stylesheet\"
                         href=\"/blog/src/css/simple.css\"
                         type=\"text/css\"/>"
 :base-directory "~/blog/"
 :base-extension "org"
 :publishing-directory "/var/www/html/blog/"
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 4             ; Just the default for this project.
 :auto-preamble t
 :author "Bear Arpher"
 :email "bearpher@gmail.com"
 :auto-sitemap t                ; Generate sitemap.org automagically...
 :sitemap-filename "index.org"  ; ... call it sitemap.org (it's the default)...
 :sitemap-title "笔记"         ; ... with title 'Sitemap'.
 :sitemap-sort-files anti-chronologically
 :sitemap-file-entry-format "%t"
;; :with-author nil             ;; 不显示作者
 :language "zh-CN"
 )

("blog-static"
 :base-directory "~/blog/"
 :base-extension "png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf|\\css"
 :publishing-directory "/var/www/html/blog/"
 :recursive t
 :publishing-function org-publish-attachment
 )



      ))

(setq org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode %f"
                              "xelatex -shell-escape -interaction nonstopmode %f"))
