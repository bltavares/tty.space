kickstart.context 'Talk'

kickstart.service.enable talk.socket
kickstart.service.enable talk

kickstart.service.restart talk.socket
kickstart.service.restart talk
