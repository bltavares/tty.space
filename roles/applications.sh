kickstart.context 'applications'

kickstart.package.install vim

source recipes/aur.sh
kickstart.package.installed alpine || nobody.packer -S --noconfirm alpine
