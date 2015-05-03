kickstart.context 'NNTP server'

kickstart.info 'Installing NNTP server'
kickstart.package.install inn
cp files/nntp/* /etc/inn
kickstart.service.restart innd
kickstart.service.enable innd

kickstart.info 'Creating groups'
ctlinnd newgroup tty.general

kickstart.info 'Installing readers'
kickstart.package.install slrn

source recipes/aur.sh
kickstart.package.installed tin || nobody.packer -S --noconfirm tin
