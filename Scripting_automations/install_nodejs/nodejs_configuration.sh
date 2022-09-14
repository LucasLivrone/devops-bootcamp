#!/bin/bash

#Install packages
sudo apt-get update
sudo apt install -y nodejs npm gcc g++ make

#Clone repo containing  server.js file
git clone https://github.com/roxsross/challenge-linux-bash

#Get and install Node version 14
curl -sL https://deb.nodesource.com/setup_14.x -o node_setup.sh
sudo bash node_setup.sh

#Create configuration file for the Node service
sudo touch /lib/systemd/system/devops@.service

#Setup configuration file
sudo cat > /lib/systemd/system/devops@.service << EOF
[Unit]
Description=Balanceo para desafio Final
Documentation=https://github.com/roxsross/challenge-linux-bash
After=network.target


[Service]
Enviroment=PORT=%i
Type=simple
User=nodejs
WorkingDirectory=//home/ubuntu/challenge-linux-bash
ExecStart=/usr/bin/node /home/ubuntu/challenge-linux-bash/server.js
Restart=on-failure


[Install]
WantedBy=multi-user.target
EOF