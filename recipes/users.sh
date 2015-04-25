user.exist?() {
  kickstart.mute id $1
  echo $?
}

user.create() {
  user=$1
  userAlreadyExists=$(user.exist? $user)

  kickstart.user.create $user 'changeme'

  if [ $userAlreadyExists != 0 ]; then
    kickstart.info "New user found, created with default password. Expiring password for $user"
    kickstart.mute passwd -e $user
  fi
}

user.homeFolder() {
  grep $1 /etc/passwd | cut -d: -f 6
}

user.setAuthorizedKeys() {
  user=$1
  homeFolder=$(user.homeFolder $user)

  mkdir -p $homeFolder/.ssh
  cat > $homeFolder/.ssh/authorized_keys

  chmod 755 $homeFolder/.ssh
  chmod 600 $homeFolder/.ssh/authorized_keys
  chown -R $user:$user $homeFolder/.ssh
}

