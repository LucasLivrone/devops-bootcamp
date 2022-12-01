#!/bin/bash

# Install docker
apt-get update
apt install docker.io -y


# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


# Clone repo with source code of the app
git clone https://github.com/roxsross/devops-practice-tools.git


# Create Dockerfile for the backend
cd devops-practice-tools/docker/challenge/poke-app/backend-pokemon-app
cat > Dockerfile << EOF
FROM python:3.8
WORKDIR /backend
COPY . /backend
RUN pip install -r /backend/requirements.txt
EXPOSE 8000
CMD ["python", "main.py"]
EOF


# Build backend container
docker build -t backend_pokemon .


# Run backend container
docker run -d --name backend_pokemon -p 8000:8000 backend_pokemon


# Create Dockerfile for the frontend
cd ../frontend-pokemon-app/
cat > Dockerfile << EOF
FROM node:16
WORKDIR /frontend
ENV PATH /frontend/node_modules/.bin:$PATH
COPY . /frontend
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent
EXPOSE 3000
CMD [ "npm", "start" ]
EOF


# Build bfrontendackend container
docker build -t frontend_pokemon .


# Run frontend container
docker run -d --name frontend_pokemon -p 3000:3000 frontend_pokemon

