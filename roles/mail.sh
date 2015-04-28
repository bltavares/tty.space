kickstart.context 'Mail'

kickstart.package.install postfix

cp files/postfix.cf /etc/postfix/main.cf
newaliases

kickstart.service.restart postfix
