#!/bin/bash

#Initiate the service in one port:
PORT=3000
sudo systemctl enable devops@$PORT
sudo systemctl start devops@$PORT


#Command used to replace string '%i' with the variable $PORT inside the configuration file. (Not needed in this scenario)
#sed -i "s/%i/$PORT/g" /lib/systemd/system/devops@.service


# Initiate service in multiple ports:
# for port in $(seq 3000 3003); do sudo systemctl enable devops@$port; done