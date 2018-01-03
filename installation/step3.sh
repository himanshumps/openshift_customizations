#! /bin/sh
#12.	Run the following for loop to configure Docker storage on the other nodes, enable Docker, and restart the node
scp root@master1.example.com:/etc/sysconfig/docker-storage-setup ./
for node in infranode1.example.com \
	node1.example.com \
	node2.example.com; \
	do
		echo Configuring Docker Storage and rebooting $node
		scp docker-storage-setup ${node}:/etc/sysconfig/docker-storage-setup
		ssh $node "
		docker-storage-setup ;
		systemctl enable docker
		systemctl start docker"
done
#1.	Verify that the Docker service has started on all nodes:
sleep 30
for node in   master1.example.com \
	infranode1.example.com \
	node1.example.com \
	node2.example.com; \
	do
		echo Checking docker status on $node
		ssh $node "systemctl status docker | grep Active" 
done
REGISTRY="registry.access.redhat.com";PTH="openshift3"
OSE_VERSION=$(yum info atomic-openshift | grep Version | awk '{print $3}')
#5.	Now on the bastion host, pull down the Docker images to node1 and node2 in the primary region with the following command(it is a time taking process):
for node in  node1.example.com \
                                   node2.example.com; \
do
ssh $node "
docker pull $REGISTRY/$PTH/ose-deployer:v$OSE_VERSION ; \
docker pull $REGISTRY/$PTH/ose-sti-builder:v$OSE_VERSION ; \
docker pull $REGISTRY/$PTH/ose-pod:v$OSE_VERSION ; \
docker pull $REGISTRY/$PTH/ose-keepalived-ipfailover:v$OSE_VERSION ; \
docker pull $REGISTRY/$PTH/ruby-20-rhel7 ; \
docker pull $REGISTRY/$PTH/mysql-55-rhel7 ; \
docker pull openshift/hello-openshift:v1.2.1 ;
"
done


