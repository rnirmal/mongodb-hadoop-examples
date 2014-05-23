#!/bin/bash

sudo initctl stop hiveserver2
sudo initctl stop hive-metastore

echo "[HDP-2.1.2.0]
name=Hortonworks Data Platform Version - HDP-2.1.2.0
baseurl=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.1.2.0
gpgcheck=1
gpgkey=http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.1.2.0/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
enabled=1
priority=1" | sudo tee -a /etc/yum.repos.d/hdp-updates.repo

sudo yum -y check-update
sudo yum -y install hive

sudo initctl start hiveserver2
sudo initctl start hive-metastore
