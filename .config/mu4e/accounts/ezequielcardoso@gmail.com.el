(add-to-list 'mu4e-contexts
(make-mu4e-context
  :name "ezequielcardoso@gmail.com"
  :match-func (lambda (msg)
                (when msg
                  (mu4e-message-contact-field-matches msg
                     :to "ezequielcardoso@gmail.com")))
  :vars '((user-mail-address                . "ezequielcardoso@gmail.com")
          (message-sendmail-extra-arguments . ("-a" "ezequielcardoso@gmail.com"))
          (mu4e-sent-messages-behavior      . delete)
          (mu4e-drafts-folder               . "/ezequielcardoso@gmail.com/[Gmail].Drafts")
          (mu4e-trash-folder                . "/ezequielcardoso@gmail.com/Trash")
          (mu4e-sent-folder                 . "/ezequielcardoso@gmail.com/[Gmail].Sent Mail")
          (mu4e-maildir-shortcuts           . (("/ezequielcardoso@gmail.com/INBOX" . ?i)
                                               ("/ezequielcardoso@gmail.com/[Gmail].Drafts"         . ?d)
                                               ("/ezequielcardoso@gmail.com/[Gmail].Sent Mail" . ?s)))
          (user-full-name                   . "Ezequiel Cardoso"))))
