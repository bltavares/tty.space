kickstart.context 'cron'

kickstart.info 'Arch Linux does not have cron anymore. It uses systemd timers.'

kickstart.package.install cronie

kickstart.service.restart cronie
kickstart.service.enable cronie
