kickstart.context 'Mail'

kickstart.package.install postfix

cp files/postfix.cf /etc/postfix/main.cf
newaliases

kickstart.service.enable postfix
kickstart.service.restart postfix


if [ -s new_users.tmp ]; then
    kickstart.info "Sending welcome email for new users"
    for f in files/emails/*; do
        title=$(basename "$f")
        mail -s "$title" $(cat new_users.tmp) < "$f"
    done
    rm new_users.tmp
fi
