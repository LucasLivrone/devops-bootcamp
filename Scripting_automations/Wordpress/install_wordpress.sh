#!/bin/bash

#Installing dependencies
echo "Installing dependencies"

sudo apt update
sudo apt install apache2 ghostscript libapache2-mod-php mysql-server php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip -y

#Installing Wordpress
echo "Installing Wordpress"
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www


#Configurating Wordpress
echo "Configurating Wordpress"

sudo touch /etc/apache2/sites-available/wordpress.conf


sudo cat > /etc/apache2/sites-available/wordpress.conf << EOF
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOF


#Enable the site with:

sudo a2ensite wordpress

#Enable URL rewriting with:

sudo a2enmod rewrite

#Disable the default “It Works” site with:

sudo a2dissite 000-default


#Finally, reload apache2 to apply all these changes:

sudo service apache2 reload


#Configurating Wordpress database
echo "Configurating Wordpress database"


# Function used to create the DB giving name, user & password
database() {
    echo -e "\e[32;1;3mCreating database\e[m"
    tee /home/ubuntu/wordpress.sql << STOP
/* CREATE DATABASE wordpress;
CREATE USER wordpress@localhost IDENTIFIED BY 'P@ssword321'; */
GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost;
FLUSH PRIVILEGES;
quit
STOP
}



# Database creation using the function

database

sudo mysql --verbose -u root < /home/ubuntu/wordpress.sql

#Enable MySQL

sudo service mysql start

#Connect wordpress to DB

sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/P@ssword321/' /srv/www/wordpress/wp-config.php

#Update Wordpress configuration
sudo chmod 777 /srv/www/wordpress/wp-config.php
sudo -u www-data sed '51,58d' /srv/www/wordpress/wp-config.php > /srv/www/wordpress/wp-config.php
