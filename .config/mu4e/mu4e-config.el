;;; mu4e-config.el --- Configuración de mu4e para Ezequiel -*- lexical-binding: t; -*-

;;; ------------------------------------------------------------------
;;; CARGA BASE Y RUTAS
;;; ------------------------------------------------------------------

(setq exec-path (cons "/usr/local/bin" exec-path))

;;; ------------------------------------------------------------------
;;; CONFIGURACIÓN DE MU4E PRINCIPAL (after! asegura la carga correcta)
;;; ------------------------------------------------------------------

(after! mu4e
  ;; Soporte integrado para Org-mode en mu4e moderno
  (setq mu4e-org-support t)

  ;;; ----------------------------------------------------------------
  ;;; MAILDIR, SINCRONIZACIÓN Y CARPETAS DE GMAIL
  ;;; ----------------------------------------------------------------
  (setq mu4e-maildir "/home/ezequiel/Maildir/"
        mu4e-get-mail-command "mbsync -c ~/.config/mu4e/mbsyncrc -a"
        mu4e-update-interval (* 5 60))

  ;; Mapeo nativo de carpetas para Gmail (Soluciona el error al borrar correos)
  (setq mu4e-drafts-folder "/[Gmail]/Drafts"
        mu4e-sent-folder   "/[Gmail]/Sent Mail"
        mu4e-trash-folder  "/[Gmail]/Bin"
        mu4e-refile-folder "/[Gmail]/All Mail")

  ;;; ----------------------------------------------------------------
  ;;; IDENTIDAD Y ENVÍO (SMTP)
  ;;; ----------------------------------------------------------------
  (setq auth-sources '("~/.authinfo.gpg"))

  (setq user-mail-address "ezequielcardoso@gmail.com"
        user-full-name    "Ezequiel Cardoso")

  (require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-smtp-user          "ezequielcardoso@gmail.com"
        smtpmail-smtp-server        "://gmail.com"
        smtpmail-smtp-service       587
        smtpmail-stream-type        'starttls)

  ;;; ----------------------------------------------------------------
  ;;; VISUALIZACIÓN DE HTML
  ;;; ----------------------------------------------------------------
  (setq mu4e-html2text-command 'mu4e-shr2text
        shr-use-colors t
        mu4e-view-html-plaintext-ratio-heuristic most-positive-fixnum)
  
  (add-to-list 'mu4e-headers-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

  ;;; ----------------------------------------------------------------
  ;;; COMPOSICIÓN Y COLUMNAS DE CABECERA
  ;;; ----------------------------------------------------------------
  (add-hook 'mu4e-compose-mode-hook #'flyspell-mode)

  (add-to-list 'mu4e-header-info-custom
               '(:time .
                 (:name "Hora"
                  :shortname "Hora"
                  :help "Hora de envío del mensaje"
                  :function (lambda (msg)
                              (format-time-string "%H:%M" (mu4e-msg-field msg :date))))))

  (setq mu4e-headers-fields
        '((:human-date . 12)
          (:time       . 6)
          (:flags      . 6)
          (:mailing-list . 10)
          (:from       . 22)
          (:subject    . nil)))

  ;;; ----------------------------------------------------------------
  ;;; BOOKMARKS PERSONALIZADOS
  ;;; ----------------------------------------------------------------
  (setq mu4e-bookmarks
        '((:name "Unread messages"     :query "flag:unread AND NOT flag:trashed" :key ?u)
          (:name "Today's messages"    :query "date:today..now"                  :key ?t)
          (:name "Last 7 days"         :query "date:7d..now" :hide-unread t      :key ?w)
          (:name "Messages with images" :query "mime:image/*"                     :key ?p)
          (:name "Big messages"        :query "size:5M..500M"                    :key ?b)))

  (add-to-list 'mu4e-bookmarks '(:name "Arch Linux"      :query "Arch OR arch OR \"Arch Linux\" OR \"arch linux\" OR arch-linux OR Arch-Linux" :key ?a))
  (add-to-list 'mu4e-bookmarks '(:name "Emacs"           :query "emacs OR org OR orgmode OR \"org-mode\" OR mu4e" :key ?e))
  (add-to-list 'mu4e-bookmarks '(:name "Programación"    :query "\"web dev\" OR web OR html OR css OR javascript OR php OR laravel OR python OR wordpress OR programación OR code OR coding" :key ?p))
  (add-to-list 'mu4e-bookmarks '(:name "Busqueda Laboral" :query "jr OR remoto OR trabajo OR work OR remote" :key ?l))
  (add-to-list 'mu4e-bookmarks '(:name "Familia"         :query "hola@zoeraijman.com OR luciocardosoraijman@gmail.com" :key ?f))
  (add-to-list 'mu4e-bookmarks '(:name "Dante Alighieri" :query "facturas@escueladantecordoba.edu.ar OR escueladantealighieri@miescueladigital.com.ar OR preceptoria1c@escueladantecordoba.edu.ar" :key ?d))
  (add-to-list 'mu4e-bookmarks '(:name "Inversiones"     :query "no-reply@invertironline.com OR invertironline OR no-reply@cocos.capital OR investing.com OR rankia OR noreply@cajadevalores.com.ar OR atencion@cocos.capital" :key ?i))

  ;;; ----------------------------------------------------------------
  ;;; ESTÉTICA VISUAL NANO (Nicolas Rougier) - ADAPTADO PARA MU 1.14+
  ;;; ----------------------------------------------------------------
  (setq mu4e-search-threads t
        mu4e-search-include-related t
        mu4e-search-skip-duplicates t)

  (use-package! nano-mu4e
    :hook ((mu4e-headers-mode . nano-mu4e-mode)
           (mu4e-main-mode . nano-mu4e-mode))))

;;; ------------------------------------------------------------------
;;; INTEGRACIONES EXTERNAS (Fuera de after! mu4e para estabilidad)
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
