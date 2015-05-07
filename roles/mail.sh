kickstart.context 'Mail'

kickstart.package.install postfix

cp files/postfix.cf /etc/postfix/main.cf
newaliases

kickstart.service.enable postfix
kickstart.service.restart postfix

if [ -f new_users.tmp ]; then
 mail -s "Welcome to tty.space" $(cat new_users.tmp) < files/welcome.mail
 rm new_users.tmp
fi
