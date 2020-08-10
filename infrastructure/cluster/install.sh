#!/bin/bash

cd /home/ubuntu

# install code deploy
sudo apt-get update
sudo apt-get install ruby -y
sudo apt-get install wget -y

# install apache
sudo apt-get install apache2 -y
sudo service httpd start
echo "<h1>Test Linux Instance</h1>" | sudo tee /var/www/html/index.html


wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start


# install aws logs
sudo apt install python -y
wget https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py
wget https://s3.amazonaws.com/aws-codedeploy-us-east-1/cloudwatch/codedeploy_logs.conf
chmod +x ./awslogs-agent-setup.py
sudo python awslogs-agent-setup.py -n -r us-east-1 -c s3://aws-codedeploy-us-east-1/cloudwatch/awslogs.conf
sudo mkdir -p /var/awslogs/etc/config
sudo cp codedeploy_logs.conf /var/awslogs/etc/config/
sudo service awslogs restart

