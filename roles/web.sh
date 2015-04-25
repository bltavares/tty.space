kickstart.context "Web server"

source recipes/web.sh

kickstart.package.update
kickstart.package.install nginx

cp files/nginx.conf /etc/nginx/nginx.conf

mkdir -p /var/web
userlist="$(web.userList)" \
  kickstart.file.template files/web/index.html.tpl > /var/web/index.html

kickstart.service.enable nginx
kickstart.service.restart nginx
