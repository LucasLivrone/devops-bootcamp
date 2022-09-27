#!/bin/bash

#Initiate the service in one port:
#PORT=3000
#sudo systemctl enable devops@$PORT
#sudo systemctl start devops@$PORT


#Command used to replace string '%i' with the variable $PORT inside the configuration file. (Not needed in this scenario)
#sed -i "s/%i/$PORT/g" /lib/systemd/system/devops@.service


# Initiate service in multiple ports:
for port in $(seq 3000 3003); do sudo systemctl enable devops@$port; done

for port in $(seq 3000 3003); do sudo systemctl start devops@$port; done



# Restart nginx
sudo systemctl restart nginx


#Install certificate
# Remeber to reeplace ip_publica with the correct IP and use a real mail account
sudo apt install certbot python3-certbot-nginx
sudo certbot --non-interactive --nginx -d ip_publica.sslip.io -d www.ip_publica.sslip.io -m xxxxxx@gmail.com --agree-tos
sudo certbot renew --dry-run
