#!/bin/bash

# Install docker
apt-get update
apt install docker.io -y


# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


# Clone repo with source code of the app
git clone https://github.com/roxsross/devops-practice-tools.git


# I want to remove the "solutions" files provided by the teacher
rm -rf devops-practice-tools/docker/challenge/poke-app/user-data/
rm -rf devops-practice-tools/docker/challenge/poke-app/docker-compose.local.yml
rm -rf devops-practice-tools/docker/challenge/poke-app/docker-compose.prod.yml
rm -rf devops-practice-tools/docker/challenge/poke-app/backend-pokemon-app/Dockerfile
rm -rf devops-practice-tools/docker/challenge/poke-app/frontend-pokemon-app/Dockerfile


# Force the code to run on localhost
cat > devops-practice-tools/docker/challenge/poke-app/frontend-pokemon-app/.env << EOF
REACT_APP_URL_DEVELOPMENT=http://localhost:8000
REACT_APP_URL_PRODUCTION=http://localhost:8000
EOF
# In the future I would want to use REACT_APP_URL_PRODUCTION=https://api.PUBLIC_IP.nip.io
# If im running on AWS EC2: PUBLIC_IP=$(curl http://checkip.amazonaws.com)

# Create Dockerfile for the backend
cd devops-practice-tools/docker/challenge/poke-app/backend-pokemon-app
cat > Dockerfile << EOF
FROM python:3.8-alpine
WORKDIR /backend
COPY . ./
RUN pip install -r ./requirements.txt
EXPOSE 8000
CMD ["python", "main.py"]
EOF


# Build and run backend container
# docker build -t backend_pokemon .
# docker run -d --name backend_pokemon -p 8000:8000 backend_pokemon


# Create Dockerfile for the frontend
cd ../frontend-pokemon-app/
cat > Dockerfile << EOF
FROM node:16.3.0-alpine
WORKDIR /frontend
COPY package.json ./
RUN npm install
COPY . ./
EXPOSE 3000
CMD [ "npm", "start" ]
EOF


# Build and run frontend container
# docker build -t frontend_pokemon .
# docker run -d --name frontend_pokemon -p 3000:3000 frontend_pokemon


# Create docker-compose.yml
cd ..
cat > docker-compose.yml << EOF
version: '3'
services:
  backend_pokemon:
    container_name: backend_pokemon
    build: ./backend-pokemon-app/
    ports:
    - "8000:8000"
    networks:
    - poke_network

  frontend_pokemon:
    container_name: frontend_pokemon
    build: ./frontend-pokemon-app/
    ports:
    - "3000:3000"
    depends_on:
    - backend_pokemon
    networks:
    - poke_network

networks:
  poke_network:
    driver: bridge
EOF


# Build and run docker-compose to run both backend and frontend
docker-compose up
