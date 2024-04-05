#The base image for the container 
FROM python:3.12.2-slim-bullseye
 
# Keeps Python from generating .pyc files in the container 
ENV PYTHONDONTWRITEBYTECODE=1 
 
# Turns off buffering for easier container logging 
ENV PYTHONUNBUFFERED=1 

RUN apt-get -y update; apt-get -y install curl

# Get Rust; NOTE: using sh for better compatibility with other base images
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add .cargo/bin to PATH
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustc --version

# Copy python requirements to the docker container and install
COPY requirements.txt . 
RUN python -m pip install -r requirements.txt 
 
#create a non root user to access the container
RUN adduser -u 5678 --disabled-password --gecos "" vscode