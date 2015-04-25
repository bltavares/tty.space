kickstart.context "Web server"

kickstart.package.update
kickstart.package.install nginx

kickstart.service.enable nginx
kickstart.service.start nginx
