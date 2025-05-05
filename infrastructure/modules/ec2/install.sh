#!bin/bash

yum update -y
yum install -y java-1.8.0-openjdk wget

useradd nexus

cd /opt
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -xvzf latest-unix.tar.gz
mv nexus-* nexus
chown -R nexus:nexus nexus

echo 'user="nexus"' > /opt/nexus/bin/nexus.rc

su - nexus -c "/opt/nexus/bin/nexus start"

chmod +x install.sh