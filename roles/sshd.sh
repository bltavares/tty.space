kickstart.context 'SSH'

cp files/sshd_config /etc/ssh/sshd_config
kickstart.service.restart sshd
