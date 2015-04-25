kickstart.context 'Security'

kickstart.package.update
kickstart.package.install sshguard

kickstart.service.start sshguard
kickstart.service.enable sshguard

kickstart.info 'Setting up firewall'
iptables -F
iptables -N sshguard
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -j sshguard
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-rst
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable
iptables -P INPUT DROP

iptables-save > /etc/iptables/iptables.rules
kickstart.service.restart iptables
kickstart.service.enable iptables
