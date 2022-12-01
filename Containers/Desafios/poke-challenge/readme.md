## Poke-Challenge

Instructions:
https://github.com/roxsross/devops-practice-tools/tree/master/docker/challenge/poke-app

---

### poke-challenge.sh
```
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
docker run -d -p 8000:8000 backend_pokemon



```

---

### restart-poke-challenge.sh
```
#!/bin/bash

# Stop and remove containers
docker stop backend_pokemon
docker rm backend_pokemon

# Remove files
cd
rm -rf devops-practice-tools
```