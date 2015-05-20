web.userList() {
  echo '<ul>'
  for user in /home/*; do
    username="$(basename "$user")"
    echo "<li><a href='/~$username'>$username</a></li>"
  done
  echo '</ul>'
}
