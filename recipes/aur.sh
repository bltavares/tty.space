install.packer() {
  kickstart.info 'setting up packer'
  rm -rf /tmp/packer
  (cd /tmp && curl https://aur4.archlinux.org/cgit/aur.git/snapshot/packer.tar.gz | tar xz)
  chown -R nobody:nobody /tmp/packer
  kickstart.package.install jshon
  kickstart.package.install expac
  kickstart.package.install sudo
  kickstart.package.install base-devel
  kickstart.package.install git
  kickstart.user.exec nobody 'cd /tmp/packer && makepkg'
  pacman --noconfirm -U /tmp/packer/packer*.pkg.tar.xz
}

kickstart.command_exists packer || install.packer

nobody.packer() {
  (
  makepkg() {
    chown nobody:nobody .
    sudo -u nobody /usr/bin/makepkg -f
  }
  export -f makepkg
  packer "$@"
  )
}
