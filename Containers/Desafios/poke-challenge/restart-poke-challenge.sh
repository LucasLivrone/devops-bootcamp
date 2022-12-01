#!/bin/bash

# Stop and remove containers
docker stop backend_pokemon
docker rm backend_pokemon

# Remove files
cd
rm -rf devops-practice-tools