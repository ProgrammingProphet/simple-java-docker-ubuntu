# Docker Setup & Verification Guide (Ubuntu / AWS EC2)

This document explains how to:

* Verify Docker installation
* Check if the Docker daemon is running
* Fix user permission issues (docker group)
* Enable BuildKit
* Install and verify `buildx`
* Install official Docker CE (recommended for DevOps)

This guide is intended for Ubuntu systems running on AWS EC2.

---

# 1️⃣ Verify Docker Installation

Check Docker version:

```bash
docker --version
```

Expected output example:

```
Docker version 24.x.x, build xxxxx
```

If command not found → Docker is not installed.

---

# 2️⃣ Check If Docker Daemon Is Running

```bash
sudo systemctl status docker
```

Look for:

```
Active: active (running)
```

If not running:

```bash
sudo systemctl start docker
```

Enable on boot:

```bash
sudo systemctl enable docker
```

---

# 3️⃣ Fix "Cannot connect to Docker daemon" Error

If you see:

```
Cannot connect to the Docker daemon at unix:///var/run/docker.sock
```

Test with sudo:

```bash
sudo docker ps
```

If this works → it is a permission issue.

Add current user to docker group:

```bash
sudo usermod -aG docker $USER
```

Reload group:

```bash
newgrp docker
```

Or logout and login again.

Verify:

```bash
docker ps
```

---

# 4️⃣ Check If User Is Logged Into Docker Hub

Check Docker config:

```bash
cat ~/.docker/config.json
```

Or:

```bash
docker info | grep Username
```

If logged in, it will show:

```
Username: your_dockerhub_username
```

Login if needed:

```bash
docker login
```

---

# 5️⃣ Enable BuildKit (Modern Docker Builder)

Temporary (current session):

```bash
export DOCKER_BUILDKIT=1
```

Permanent (daemon-level):

Edit:

```bash
sudo nano /etc/docker/daemon.json
```

Add:

```json
{
  "features": {
    "buildkit": true
  }
}
```

Restart Docker:

```bash
sudo systemctl restart docker
```

---

# 6️⃣ Check If Buildx Is Installed

```bash
docker buildx version
```

If you see:

```
docker: unknown command: buildx
```

It is not installed.

---

# 7️⃣ Install Buildx Plugin

```bash
sudo apt update
sudo apt install docker-buildx-plugin
```

Verify:

```bash
docker buildx version
```

---

# 8️⃣ Install Official Docker CE (Recommended)

If you previously installed Docker via:

```bash
sudo apt install docker.io
```

It is better to switch to official Docker CE.

## Remove Old Docker

```bash
sudo apt remove docker docker-engine docker.io containerd runc
```

## Install Dependencies

```bash
sudo apt update
sudo apt install ca-certificates curl gnupg
```

## Add Docker GPG Key

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

## Add Official Repository

```bash
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## Install Docker CE + Plugins

```bash
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Verify installation:

```bash
docker --version
docker buildx version
```

---

# 9️⃣ Useful Verification Commands

Check Docker info:

```bash
docker info
```

Check running containers:

```bash
docker ps
```

Check images:

```bash
docker images
```

---

# 🎯 Recommended DevOps Setup Checklist

* [ ] Docker CE installed (official repository)
* [ ] Docker service running
* [ ] User added to docker group
* [ ] BuildKit enabled
* [ ] buildx installed
* [ ] Able to build and run containers without sudo

---

# 🚀 Learning Outcome

After completing this setup, you will understand:

* Docker daemon architecture
* User permission management
* Modern BuildKit workflow
* Plugin-based Docker CLI
* Production-ready Docker installation practices

---

This guide ensures your Ubuntu/AWS EC2 environment is configured according to modern Docker standards.
