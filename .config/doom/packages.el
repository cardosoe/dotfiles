;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)

;; (package! gitconfig-mode
;; 	  :recipe (:host github :repo "magit/git-modes"
;; 			 :files ("gitconfig-mode.el")))
;; (package! gitignore-mode
;; 	  :recipe (:host github :repo "magit/git-modes"
;; 			 :files ("gitignore-mode.el")))
(package! spell-fu)
(package! flycheck-aspell)
(package! async)
(package! calfw)
(package! calfw-gcal)
(package! calfw-org)
(unpin! org-roam)
(package! org-roam-ui)
;; (package! org-contacts)
(package! dashboard)
(package! dired-open)
(package! dired-subtree)
(package! dmenu)
(package! elfeed-goodies)
(package! emojify)
(package! esxml)
(package! evil-tutor)
(package! ivy-posframe)
(package! mw-thesaurus)
(package! org-auto-tangle)
(package! org-superstar)
(package! org-super-agenda)
(package! org-board)
(package! org-web-tools)
(package! easy-hugo)
(package! ox-hugo)
(package! peep-dired)
(package! password-store)
(package! rainbow-mode)
(package! request)
(package! resize-window)
(package! all-the-icons-dired)
(package! tldr)
(package! beacon)
(package! clippy)
(package! minimap)
(package! php-cs-fixer)
(package! request-deferred)
(package! deferred)
(package! writeroom-mode)
(package! octicons)
(package! neotree)
(package! xwidgete)
(package! org-books)
(package! org-chef)
(package! mu4e-alert)
(package! olivetti)
(package! company-tabnine :recipe (:host github :repo "TommyX12/company-tabnine"))
(package! anaconda-mode )
(package! conda)
(package! nose)
(package! pipenv)
(package! code-cells)
(package! jupyter)
(package! ein)
(package! envrc)
(package! pip-requirements)
(package! pyenv)
(package! pyimport)
(package! python-pytest)
(package! pip-requirements)
(package! py-isort)
(package! lsp-pyright)
(package! language-id)
(package! pyenv-mode)
(package! format-all)
(package! dap-mode)
(package! org-modern)
(package! org-mode)
(package! org-ref)
(package! ivy-bibtex)
(package! sqlite3)
(package! calibredb)
(package! org-calibre-notes)
(package! org-roam-bibtex)
(package! ellama)
(package! llm)
(package! nov)
(package! phpunit)
(package! composer)
(package! org-msg)
;;; Recetas personalizadas para el ecosistema de Nicolas Rougier
(package! nano-mu4e :recipe (:host github :repo "rougier/nano-mu4e"))
(package! lsp-ui)
(package! dotenv-mode)
(package! reformatter)   ; solo si activás el bloque opcional de php-cs-fixer
