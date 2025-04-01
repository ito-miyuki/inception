# 🐳 Inception -Learn Docker!

This repository contains the implementation of the **Inception** project, a system administration assignment designed to deepen understanding of Docker and container-based infrastructure.

## Project Overview

The goal of the project is to build a secure and functional Docker-based infrastructure from scratch, using only minimal base images like Alpine or Debian.

All components are containerized, and the setup is orchestrated with `docker-compose`. The entire project is developed and tested inside a virtual machine environment.

## Mandatory Components

The infrastructure includes the following services:

- **NGINX**  
  Serves as the single entry point to the system via HTTPS (TLSv1.2 or TLSv1.3 only).

- **MariaDB**  
  Provides a relational database service. Configured with a non-default administrator user.

- **WordPress + PHP-FPM**  
  Installed and configured to work without NGINX in the container. Uses volumes to persist data.

- **Volumes**  
  - One for WordPress website files.
  - One for the WordPress database.

- **Docker Network**  
  A custom bridge network connects all containers securely.

## Key Requirements

- Each service runs in its own Docker container.
- Containers are built from your own Dockerfiles (no prebuilt images allowed, except Alpine/Debian).
- No use of `latest` tags or insecure practices like `tail -f`, infinite loops, or `sleep infinity`.
- Use of `.env` file for storing credentials and environment variables.
- Only the NGINX container should expose port 443.
- Containers must automatically restart upon failure.

## Project Structure

```bash
.
├── Makefile
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── nginx/
        ├── wordpress/
        └── mariadb/

```

## Skills Learned
 - Docker image and container management
 - Dockerfile writing best practices
 - Docker Compose networking and volume sharing
 - Secure server configuration with NGINX and TLS
 - Environment variable and secret management
 - Service orchestration and fault tolerance

