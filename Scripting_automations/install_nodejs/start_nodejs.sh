#!/bin/bash

PORT=3000

#Este comando no se necesita, pero sirve para reemplazar el string '%i' por la variable $PORT dentro de un archivo
#sed -i "s/%i/$PORT/g" /lib/systemd/system/devops@.service

sudo systemctl enable devops@$PORT

sudo systemctl start devops@$PORT

