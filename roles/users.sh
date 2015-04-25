kickstart.context 'Users'

source recipes/user.sh

kickstart.info 'Enable mail spool for new users'
sed -i'' 's/CREATE_MAIL_SPOOL=no/CREATE_MAIL_SPOOL=yes/' /etc/default/useradd

kickstart.info 'Seting up /etc/skel files'

mkdir -p /etc/skel/public_html
touch /etc/skel/public_html/index.html
chmod -R 755 /etc/skel/public_html

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

