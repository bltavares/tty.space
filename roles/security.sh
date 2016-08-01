kickstart.context 'Security'

kickstart.package.update
kickstart.package.install sshguard

kickstart.service.start sshguard
kickstart.service.enable sshguard

kickstart.info 'Setting up firewall'
iptables -F
iptables -N sshguard || true
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -j sshguard
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 5000:6000 -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-rst
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable
iptables -P INPUT DROP

iptables-save > /etc/iptables/iptables.rules
kickstart.service.restart iptables
kickstart.service.enable iptables

ip6tables -F
ip6tables -N sshguard || true
ip6tables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
ip6tables -A INPUT -j sshguard
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 443 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 5000:6000 -j ACCEPT
ip6tables -A INPUT -m conntrack --ctstate INVALID -j DROP
ip6tables -A INPUT -p ipv6-icmp --icmpv6-type 8 -m conntrack --ctstate NEW -j ACCEPT
ip6tables -A INPUT -p udp -j REJECT --reject-with icmp6-port-unreachable
ip6tables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
ip6tables -A INPUT -j REJECT
ip6tables -P INPUT DROP
ip6tables-save > /etc/iptables/ip6tables.rules

kickstart.service.restart ip6tables
kickstart.service.enable ip6tables
