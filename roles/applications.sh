kickstart.context 'applications'

kickstart.package.install vim
kickstart.package.install mutt

source recipes/aur.sh
kickstart.package.installed alpine || nobody.packer -S --noconfirm alpine
