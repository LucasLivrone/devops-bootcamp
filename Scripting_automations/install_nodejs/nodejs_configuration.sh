#!/bin/bash

#Install packages
sudo apt-get update
sudo apt install -y nodejs nginx npm gcc g++ make

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
User=ubuntu
WorkingDirectory=/home/ubuntu/challenge-linux-bash
ExecStart=/usr/bin/node /home/ubuntu/challenge-linux-bash/server.js
Restart=on-failure


[Install]
WantedBy=multi-user.target
EOF

#Configure NGINX
sudo truncate -s0 /etc/nginx/sites-available/default
sudo cat > /etc/nginx/sites-available/default << EOF
server  {
	listen 80 default_server;
	listen [::]:80 default_server;
	
	server_name _;
	
	location / {
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Host $host;
		proxy_http_version 1.1;
		proxy_pass http://backend;
	}
}

upstream backend {
	server 127.0.0.1:3000;
	server 127.0.0.1:3001;
	server 127.0.0.1:3002;
	server 127.0.0.1:3003;
}
EOF

