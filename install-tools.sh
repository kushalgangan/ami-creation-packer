#!/bin/sh -x
sudo yum -y update
sudo yum -y install epel-release

## install openjdk 8
sleep 5
sudo yum -y install java-1.8.0-openjdk-devel

## install ansible
sleep 5
sudo yum -y install ansible2
## install terraform
curl -O https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip
sudo unzip terraform_0.11.1_linux_amd64.zip -d /usr/bin/

## install jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum -y install jenkins
sudo sed -i 's/JENKINS_JAVA_OPTIONS=.*/JENKINS_JAVA_OPTIONS="-Djenkins.install.runSetupWizard=false -Djava.awt.headless=true"/' /etc/sysconfig/jenkins
sudo service jenkins start
sudo chkconfig jenkins on
sleep 30
sudo wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar
sudo chmod -R 777 /var/lib/jenkins/

# setting jenkins creds
#sudo echo "2.0" > /var/lib/jenkins/jenkins.install.UpgradeWizard.state
#sudo java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:admin install-plugin aws-credentials
