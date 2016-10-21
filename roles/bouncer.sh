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
