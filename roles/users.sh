kickstart.context 'Users'

source recipes/users.sh

kickstart.info 'Setting up *.keys users'

for userFile in files/users/*.keys; do
  kickstart.context "Users >> $userFile"

  user="$(basename -s .keys $userFile)"
  user.create $user
  user.setAuthorizedKeys $user < $userFile
done

kickstart.info 'Setting up *.url users'

for userFile in files/users/*.url; do
  kickstart.context "Users >> $userFile"

  user="$(basename -s .url $userFile)"
  user.create $user
  kickstart.download.stream $(cat $userFile) | user.setAuthorizedKeys $user
done

