user.create() {
  user=$1
  userAlreadyExists=$(kickstart.user.exists? "$user"; echo $?)

  kickstart.user.create "$user" 'changeme'
  chmod 711 "$(user.homeFolder "$user")"

  if [ "$userAlreadyExists" != 0 ]; then
    kickstart.info "New user found, created with default password. Expiring password for $user"
    kickstart.mute passwd -e "$user"
    echo "$user" >> new_users.tmp
  fi
}

user.setAuthorizedKeys() {
  user=$1
  homeFolder=$(kickstart.user.homeFolder "$user")

  mkdir -p "$homeFolder"/.ssh
  cat > "$homeFolder"/.ssh/authorized_keys

  chmod 755 "$homeFolder"/.ssh
  chmod 600 "$homeFolder"/.ssh/authorized_keys
  chown -R "$user":"$user" "$homeFolder"/.ssh
}

