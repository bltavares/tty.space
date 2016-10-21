kickstart.context 'Bouncer'

certificate=/etc/letsencrypt/live/tty.space/privkey.pem
[ ! -f $certificate ] && echo "Certificate not available. Apply the 'ssl' role first. Quitting." && exit 1

kickstart.info 'Installing the service'
kickstart.package.install cyrus-sasl
kickstart.package.install znc

kickstart.info 'Creating the cert file'
cat /etc/letsencrypt/live/tty.space/{privkey,fullchain}.pem > /var/lib/znc/.znc/znc.pem

kickstart.info 'Refreshing the auth service'
kickstart.service.enable saslauthd
kickstart.service.restart saslauthd

kickstart.info 'Refreshing the bouncer'
kickstart.service.enable znc
kickstart.service.restart znc

kickstart.info 'Installing Push notification module'
(
    cd /tmp
    [ -d /tmp/znc-push/.git ] || sudo -u znc git clone https://github.com/jreese/znc-push.git /tmp/znc-push
)
kickstart.user.exec znc 'cd /tmp/znc-push/ && make install'

kickstart.info 'Installing Bitlbee bridge'

kickstart.package.install bitlbee
kickstart.package.install libotr

source recipes/aur.sh
kickstart.package.installed bitlbee-facebook || nobody.packer -S --noconfirm bitlbee-facebook

cp files/bitlbee.conf /etc/bitlbee/bitlbee.conf

kickstart.service.enable bitlbee
kickstart.service.restart bitlbee
