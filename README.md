# Continuous Delivery with FastAPI and Docker

## Objective
This project demonstrates Continuous Delivery by automating the creation and deployment of a Dockerized FastAPI application using GitHub Actions.

## Setup Instructions

### 1. Setting up the FastAPI Server
Create a `main.py` file with the following code:
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}
```

Define necessary dependencies in `requirements.txt`:
```
fastapi
uvicorn
```

### 2. Containerizing the Application
Write a `Dockerfile` to package the FastAPI app into a Docker image:
```dockerfile
FROM ubuntu:latest
RUN apt update && apt install -y python3 python3-pip
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt
COPY . /app
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### 3. Creating a GitHub Actions Workflow
Define `.github/workflows/DockerBuild.yml`:
```yaml
name: Docker image build

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Build & Push Image
        run: |
          echo ${{ secrets.DOCKERTOKEN }} | docker login -u "<your-dockerhub-username>" --password-stdin
          docker build -t <your-dockerhub-username>/<image-name>:latest .
          docker push <your-dockerhub-username>/<image-name>:latest
```

## Repository Structure
```
.
├── main.py                 # FastAPI server
├── requirements.txt        # Dependencies
├── Dockerfile              # Docker configuration
├── .github/
│   └── workflows/
│       └── DockerBuild.yml # GitHub Actions Workflow
└── README.md               # Documentation
```

## Deployment Steps

### 1. Install Podman (Optional, Instead of Docker)
If using Podman instead of Docker, install and set up Podman:
```sh
podman machine init
podman machine start
alias docker=podman
docker --version
```

### 2. Generate a Docker Token
1. Go to [Docker Hub](https://hub.docker.com/) and sign in.
2. Navigate to **Account Settings → Security → Access Tokens**.
3. Click **Generate Token**.
4. Use the generated token to authenticate in GitHub Actions.

### 3. Set GitHub Actions Secrets
Add `DOCKERTOKEN` as a secret in GitHub repository settings:
```
https://github.com/<username>/<repo>/settings/secrets/actions/new
```
Use it in `DockerBuild.yml`:
```sh
echo ${{ secrets.DOCKERTOKEN }} | docker login -u "<your-dockerhub-username>" --password-stdin
```

## Submission Requirements
Provide the following:
- GitHub Repository URL containing:
  - `main.py`
  - `requirements.txt`
  - `Dockerfile`
  - `.github/workflows/DockerBuild.yml`
  - `README.md`
- Docker Hub Image URL
