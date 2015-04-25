kickstart.context "Web server"

kickstart.package.update
kickstart.package.install nginx

cp files/nginx.conf /etc/nginx/nginx.conf

kickstart.service.enable nginx
kickstart.service.restart nginx
