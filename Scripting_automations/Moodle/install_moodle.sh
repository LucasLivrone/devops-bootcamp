#!/bin/bash

echo "Install Apache/MySQL/PHP"
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt install -y apache2 mysql-client mysql-server php7.4 libapache2-mod-php


echo "Install Additional Software"
sudo apt install -y graphviz aspell ghostscript clamav php7.4-pspell php7.4-curl php7.4-gd php7.4-intl php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-ldap php7.4-zip php7.4-soap php7.4-mbstring


#Restart Apache so that the modules are loaded correctly 
sudo service apache2 restart


#Install Git
sudo apt install -y git


echo "Download Moodle using git"
cd /opt
sudo git clone git://git.moodle.org/moodle.git
cd moodle
sudo git branch -a
sudo git branch --track MOODLE_400_STABLE origin/MOODLE_400_STABLE
sudo git checkout MOODLE_400_STABLE


echo "Copy local repository to /var/www/html/"
sudo mkdir -p /var/www/html/
sudo cp -R /opt/moodle /var/www/html/
sudo mkdir /var/moodledata
sudo chown -R www-data /var/moodledata
sudo chmod -R 777 /var/moodledata
sudo chmod -R 0755 /var/www/html/moodle


echo "Setup MySQL Server"
sudo mysql -u root -p -e "
        CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
        create user 'moodle'@'localhost' IDENTIFIED BY 'mymoodlepassword123';
        GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO moodle@localhost;"


echo "Complete Setup"
sudo chmod -R 777 /var/www/html/moodle


echo "Changing php8.1 version to 7.4"
sudo a2dismod php8.1
sudo update-alternatives --set php /usr/bin/php7.4
sudo update-alternatives --config php
