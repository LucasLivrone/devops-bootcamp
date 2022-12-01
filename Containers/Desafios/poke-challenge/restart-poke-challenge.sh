#!/bin/bash

# Remove files
rm -rf /home/ubuntu/devops-practice-tools/


# Stop and remove containers
docker stop backend_pokemon
docker rm backend_pokemon

docker stop frontend_pokemon
docker rm frontend_pokemon

