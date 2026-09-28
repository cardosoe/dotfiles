;;; mu4e-config.el --- Configuración de mu4e para Ezequiel -*- lexical-binding: t; -*-

;; Requiere en packages.el (si aún no los tenés):
;;   (package! nano-mu4e      :recipe (:host github :repo "rougier/nano-mu4e"))
;;   (package! mu4e-dashboard :recipe (:host github :repo "rougier/mu4e-dashboard"))
;;   (package! mu4e-alert)
;; nano-mu4e necesita una fuente Nerd Font para los íconos.

;;; ------------------------------------------------------------------
;;; RUTAS
;;; ------------------------------------------------------------------

(add-to-list 'exec-path "/usr/local/bin")

;;; ------------------------------------------------------------------
;;; MU4E PRINCIPAL
;;; ------------------------------------------------------------------

(after! mu4e
  (setq mu4e-org-support t)

  ;; Sincronización e indexado.
  ;; `mu4e-maildir' está obsoleto: la raíz del Maildir la toma mu de su base
  ;; de datos (la que definiste con `mu init --maildir=...').
  ;; index-cleanup/lazy-check hacen mucho más rápido el indexado con una casilla
  ;; grande; esto ayuda contra "Cannot handle command while indexing".
  (setq mu4e-get-mail-command "mbsync -c ~/.config/mu4e/mbsyncrc -a"
        mu4e-update-interval (* 5 60)
        mu4e-index-cleanup nil
        mu4e-index-lazy-check t
        mu4e-hide-index-messages t)

  ;; Carpetas de Gmail
  (setq mu4e-drafts-folder "/[Gmail]/Drafts"
        mu4e-sent-folder   "/[Gmail]/Sent Mail"
        mu4e-trash-folder  "/[Gmail]/Bin"
        mu4e-refile-folder "/[Gmail]/All Mail")

  ;; Identidad y envío (SMTP)
  (setq auth-sources '("~/.authinfo.gpg")
        user-mail-address "ezequielcardoso@gmail.com"
        user-full-name    "Ezequiel Cardoso")

  (require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-smtp-user    "ezequielcardoso@gmail.com"
        smtpmail-smtp-server  "smtp.gmail.com"   ; antes decía "://gmail.com"
        smtpmail-smtp-service 587
        smtpmail-stream-type  'starttls)

  ;; HTML
  (setq mu4e-html2text-command 'mu4e-shr2text
        shr-use-colors t
        mu4e-view-html-plaintext-ratio-heuristic most-positive-fixnum)
  (add-to-list 'mu4e-headers-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t)

  ;; Composición
  (add-hook 'mu4e-compose-mode-hook #'flyspell-mode)

  ;; Bookmarks (una sola lista; la tecla ?p estaba repetida, las imágenes pasan a ?P)
  (setq mu4e-bookmarks
        '((:name "Unread messages"    :query "flag:unread AND NOT flag:trashed" :key ?u)
          (:name "Today's messages"   :query "date:today..now"                  :key ?t)
          (:name "Last 7 days"        :query "date:7d..now" :hide-unread t      :key ?w)
          (:name "Messages with images" :query "mime:image/*"                   :key ?P)
          (:name "Big messages"       :query "size:5M..500M"                    :key ?b)
          (:name "Arch Linux"
           :query "Arch OR arch OR \"Arch Linux\" OR \"arch linux\" OR arch-linux OR Arch-Linux"
           :key ?a)
          (:name "Emacs"
           :query "emacs OR org OR orgmode OR \"org-mode\" OR mu4e"
           :key ?e)
          (:name "Programación"
           :query "\"web dev\" OR web OR html OR css OR javascript OR php OR laravel OR python OR wordpress OR programación OR code OR coding"
           :key ?p)
          (:name "Busqueda Laboral"
           :query "jr OR remoto OR trabajo OR work OR remote"
           :key ?l)
          (:name "Familia"
           :query "hola@zoeraijman.com OR luciocardosoraijman@gmail.com"
           :key ?f)
          (:name "Dante Alighieri"
           :query "facturas@escueladantecordoba.edu.ar OR escueladantealighieri@miescueladigital.com.ar OR preceptoria1c@escueladantecordoba.edu.ar"
           :key ?d)
          (:name "Inversiones"
           :query "no-reply@invertironline.com OR invertironline OR no-reply@cocos.capital OR investing.com OR rankia OR noreply@cajadevalores.com.ar OR atencion@cocos.capital"
           :key ?i)))

  ;; Hilos (nano-mu4e está pensado para trabajar con hilos)
  (setq mu4e-search-threads t
        mu4e-search-include-related t
        mu4e-search-skip-duplicates t))

;;; ------------------------------------------------------------------
;;; NANO-MU4E: bandeja de entrada (estilo Rougier)
;;; ------------------------------------------------------------------

(defun my/mu4e-preview-p (msg)
  "Vista previa solo para mensajes no leídos de esta semana.
Excluye listas de correo y notificaciones de GitHub.  Cada vista previa abre
el archivo del mensaje, por eso se limita para no volver lenta una búsqueda
con miles de no leídos."
  (and (nano-mu4e-msg-is-unread msg)
       (nano-mu4e-date-is-this-week (mu4e-message-field msg :date))
       (not (nano-mu4e-msg-is-list msg))
       (not (nano-mu4e-msg-from-github msg))))

(use-package! nano-mu4e
  :after mu4e
  ;; Solo en la bandeja.  NO en `mu4e-main-mode': el modo falla fuera de
  ;; `mu4e-headers-mode' (error "nano-mu4e mode can only be used when in
  ;; mu4e-headers mode").
  :hook (mu4e-headers-mode . nano-mu4e-mode)
  :init
  (setq nano-mu4e-view-style 'regular   ; simple, regular, compact o boxed
        nano-mu4e-tag-style 'round      ; regular, square o round
        nano-mu4e-msg-preview t
        nano-mu4e-msg-preview-func #'my/mu4e-preview-p))

;; Con evil, las teclas de evil-collection en mu4e-headers-mode le ganan al
;; keymap de nano-mu4e-mode.  Esto las vuelve a poner por encima.
(after! nano-mu4e
  (when (fboundp 'evil-define-minor-mode-key)
    (evil-define-minor-mode-key 'normal 'nano-mu4e-mode
      (kbd "<tab>")     #'nano-mu4e-fold-toggle
      (kbd "<backtab>") #'nano-mu4e-fold-toggle-all
      (kbd "j")         #'nano-mu4e-next-msg
      (kbd "k")         #'nano-mu4e-prev-msg
      (kbd "<down>")    #'nano-mu4e-next-msg
      (kbd "<up>")      #'nano-mu4e-prev-msg
      (kbd "S-<down>")  #'nano-mu4e-next-thread
      (kbd "S-<up>")    #'nano-mu4e-prev-thread)))

;;; ------------------------------------------------------------------
;;; BARRA SUPERIOR DE LA BANDEJA (aproximación a la de la captura de Rougier)
;;; Esto NO viene con nano-mu4e: es un extra mío.  Borrá este bloque si no lo querés.
;;; ------------------------------------------------------------------

(defun my/nano-mu4e-toggle-preview ()
  "Activa o desactiva la vista previa de mensajes y refresca la bandeja."
  (interactive)
  (setq nano-mu4e-msg-preview (not nano-mu4e-msg-preview))
  (nano-mu4e-rerun))

(defun my/mu4e--hl-button (label action help &optional active)
  "Botón clicable para la header-line.  ACTION es una función sin argumentos."
  (let ((map (make-sparse-keymap)))
    (define-key map [header-line mouse-1]
                (lambda () (interactive) (funcall action)))
    (propertize (format " %s " label)
                'face (if active '(:inherit bold :inverse-video t) 'bold)
                'mouse-face 'highlight
                'help-echo help
                'local-map map)))

(defun my/mu4e--hl-search (label query help)
  (my/mu4e--hl-button label (lambda () (mu4e-search query)) help))

(defun my/mu4e-header-line ()
  "Header-line de la bandeja: accesos rápidos a la izquierda, opciones a la derecha."
  (let* ((sep (propertize "│" 'face 'shadow))
         (left (concat
                (my/mu4e--hl-search "Inbox"   "maildir:/INBOX" "Bandeja de entrada")
                sep
                (my/mu4e--hl-search "Unread"  "flag:unread AND NOT flag:trashed" "No leídos")
                sep
                (my/mu4e--hl-search "Today"   "date:today..now" "Mensajes de hoy")
                sep
                (my/mu4e--hl-search "Sent"    "maildir:\"/[Gmail]/Sent Mail\"" "Enviados")
                sep
                (my/mu4e--hl-search "Trash"   "maildir:\"/[Gmail]/Bin\"" "Papelera")))
         (right (concat
                 (my/mu4e--hl-button "Threads" #'mu4e-search-toggle-threading
                                     "Agrupar en hilos" mu4e-search-threads)
                 (my/mu4e--hl-button "Related" #'mu4e-search-toggle-include-related
                                     "Incluir mensajes relacionados"
                                     mu4e-search-include-related)
                 (my/mu4e--hl-button "Preview" #'my/nano-mu4e-toggle-preview
                                     "Vista previa de mensajes nuevos"
                                     nano-mu4e-msg-preview)))
         (pad (propertize " " 'display
                          `(space :align-to (- right ,(string-width right) 1)))))
    (concat left pad right)))

(add-hook 'mu4e-headers-mode-hook
          (defun my/mu4e-headers-header-line-h ()
            (setq-local header-line-format '(:eval (my/mu4e-header-line)))))

;;; ------------------------------------------------------------------
;;; MU4E-DASHBOARD: panel en Org (estilo Rougier)
;;; ------------------------------------------------------------------

(use-package! mu4e-dashboard
  :after mu4e
  :init
  (setq mu4e-dashboard-file "~/.config/doom/mu4e-dashboard.org"
        ;; con nano-mu4e este hook no se dispara, y así evitamos efectos raros
        mu4e-dashboard-propagate-keymap nil)
  :config
  (defun my/mu4e-dashboard ()
    "Arranca mu4e en segundo plano y abre el dashboard."
    (interactive)
    (mu4e t)
    (find-file mu4e-dashboard-file)
    (unless mu4e-dashboard-mode
      (mu4e-dashboard-mode 1)))

  ;; Las teclas del dashboard (u, t, i...) viven en un keymap local.  Con evil en
  ;; estado normal, evil las tapa; en estado emacs funcionan.  También quitamos
  ;; las viñetas de org-superstar para ver los "*" como en la captura.
  (add-hook 'mu4e-dashboard-mode-hook
            (defun my/mu4e-dashboard-setup-h ()
              (when (derived-mode-p 'org-mode)
                (if mu4e-dashboard-mode
                    (progn
                      (when (bound-and-true-p org-superstar-mode)
                        (org-superstar-mode -1))
                      (when (fboundp 'evil-emacs-state)
                        (evil-emacs-state)))
                  (when (fboundp 'evil-normal-state)
                    (evil-normal-state)))))))

;; Tecla para abrir el dashboard (verificá con which-key que no choque con
;; nada tuyo).  Tecla completa, sin declarar prefijo, para no pisar el menú de Doom.
(map! :leader
      :desc "mu4e dashboard" "o M" #'my/mu4e-dashboard)

;;; ------------------------------------------------------------------
;;; INTEGRACIONES EXTERNAS
;;; ------------------------------------------------------------------

(after! org
  (org-link-set-parameters "mu4e" :follow #'mu4e-org-open)
  (setq org-mu4e-link-query-in-headers-mode nil))

(use-package! mu4e-alert
  :after mu4e
  :config
  (setq mu4e-alert-email-notification-types '(count)
        mu4e-alert-notify-repeated-mails nil)
  (mu4e-alert-enable-notifications)
  (mu4e-alert-set-default-style 'libnotify))

(provide 'mu4e-config)
;;; mu4e-config.el ends here
