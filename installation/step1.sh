#! /bin/sh
export  OWN_REPO_PATH=http://admin.na.shared.opentlc.com/repos/ocp/3.6
cat << EOF > /etc/yum.repos.d/open.repo
[rhel-7-server-rpms]
name=Red Hat Enterprise Linux 7
baseurl=${OWN_REPO_PATH}/rhel-7-server-rpms
enabled=1
gpgcheck=0

[rhel-7-server-rh-common-rpms]
name=Red Hat Enterprise Linux 7 Common
baseurl=${OWN_REPO_PATH}/rhel-7-server-rh-common-rpms
enabled=1
gpgcheck=0

[rhel-7-server-extras-rpms]
name=Red Hat Enterprise Linux 7 Extras
baseurl=${OWN_REPO_PATH}/rhel-7-server-extras-rpms
enabled=1
gpgcheck=0

[rhel-7-server-optional-rpms]
name=Red Hat Enterprise Linux 7 Optional
baseurl=${OWN_REPO_PATH}/rhel-7-server-optional-rpms
enabled=1
gpgcheck=0

[rhel-7-fast-datapath-rpms]
name=Red Hat Enterprise Linux 7 Fast Datapath
baseurl=${OWN_REPO_PATH}/rhel-7-fast-datapath-rpms
enabled=1
gpgcheck=0
EOF
cat << EOF >> /etc/yum.repos.d/open.repo

[rhel-7-server-ose-3.6-rpms]
name=Red Hat Enterprise Linux 7 OSE 3.6
baseurl=${OWN_REPO_PATH}/rhel-7-server-ose-3.6-rpms
enabled=1
gpgcheck=0
EOF
mv /etc/yum.repos.d/redhat.{repo,disabled}
yum clean all ; yum repolist
for node in master1.example.com \
	infranode1.example.com \
	node1.example.com \
	node2.example.com; do
		echo Copying open repos to $node
		scp /etc/yum.repos.d/open.repo ${node}:/etc/yum.repos.d/open.repo
		ssh ${node} 'mv /etc/yum.repos.d/redhat.{repo,disabled}'
		ssh ${node} yum clean all
		ssh ${node} yum repolist
done
yum -y install bind bind-utils
echo GUID is $GUID and guid is $guid
export GUID=`hostname|cut -f2 -d-|cut -f1 -d.`
export guid=`hostname|cut -f2 -d-|cut -f1 -d.`
host infranode1-$GUID.oslab.opentlc.com ipa.opentlc.com |grep infranode | awk '{print $4}'
HostIP=`host infranode1-$GUID.oslab.opentlc.com  ipa.opentlc.com |grep infranode | awk '{print $4}'`
domain="cloudapps-$GUID.oslab.opentlc.com"
echo $HostIP $domain
mkdir /var/named/zones
echo "\$ORIGIN  .
\$TTL 1  ;  1 seconds (for testing only)
${domain} IN SOA master.${domain}.  root.${domain}.  (
  2011112904  ;  serial
  60  ;  refresh (1 minute)
  15  ;  retry (15 seconds)
  1800  ;  expire (30 minutes)
  10  ; minimum (10 seconds)
)
  NS master.${domain}.
\$ORIGIN ${domain}.
test A ${HostIP}
* A ${HostIP}"  >  /var/named/zones/${domain}.db
cat /var/named/zones/${domain}.db
echo "// named.conf
options {
  listen-on port 53 { any; };
  directory \"/var/named\";
  dump-file \"/var/named/data/cache_dump.db\";
  statistics-file \"/var/named/data/named_stats.txt\";
  memstatistics-file \"/var/named/data/named_mem_stats.txt\";
  allow-query { any; };
  recursion yes;
  /* Path to ISC DLV key */
  bindkeys-file \"/etc/named.iscdlv.key\";
  forwarders {
   192.168.0.1;
  };
  allow-recursion { 192.168.0.0/16; };
};
logging {
  channel default_debug {
    file \"data/named.run\";
    severity dynamic;
  };
};
zone \"${domain}\" IN {
  type master;
  file \"zones/${domain}.db\";
  allow-update { key ${domain} ; } ;
};" > /etc/named.conf
cat /etc/named.conf
chgrp named -R /var/named ; \
 chown named -Rv /var/named/zones ; \
 restorecon -Rv /var/named ; \
 chown -v root:named /etc/named.conf ; \
restorecon -v /etc/named.conf ;
systemctl enable named && systemctl start named
iptables -I INPUT 1 -p tcp --dport 53 -s 0.0.0.0/0 -j ACCEPT ; \
iptables -I INPUT 1 -p udp --dport 53 -s 0.0.0.0/0 -j ACCEPT ; \
iptables-save > /etc/sysconfig/iptables
host test.cloudapps-$GUID.oslab.opentlc.com 127.0.0.1
host test.cloudapps-$GUID.oslab.opentlc.com 8.8.8.8
yum -y install ansible
cat << EOF > /etc/ansible/hosts
[masters]
master1.example.com

[nodes]
master1.example.com
infranode1.example.com
node1.example.com
node2.example.com
EOF

cat /etc/ansible/hosts
ansible nodes -m ping
for node in   master1.example.com \
	infranode1.example.com \
	node1.example.com \
	node2.example.com; \
	do \
	echo installing NetworkManager on $node ; \
	ssh $node "yum -y install NetworkManager"
done
yum -y install wget git net-tools bind-utils iptables-services bridge-utils
yum -y install bash-completion
ssh master1.example.com yum -y install bash-completion
for node in master1.example.com \
	infranode1.example.com \
	node1.example.com \
	node2.example.com; \
	do \
		echo Running yum update on $node ; \
		ssh $node "yum -y update " ; \
done


