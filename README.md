# WordPress Development Environment with Docker, Caddy & Composer

This repository provides a modern and flexible local development setup for WordPress using Docker, Composer, and Caddy with automatic HTTPS support for .test domains.
It uses the Composer-based WordPress core package johnpbloch/wordpress, allowing you to manage WordPress like any other PHP dependency.

This setup is ideal for developing custom themes or plugins and supports multisite WordPress installations.

You can manage multiple independent WordPress projects using this setup.
For shared reverse proxy handling, the Caddy service can either be kept inside the project or moved to a dedicated external folder, allowing it to proxy across multiple local .test domains consistently.

---

## Features

- Docker + Docker Compose
- Composer-based WordPress (johnpbloch/wordpress)
- Local HTTPS using [Caddy](https://caddyserver.com/)
- One-command setup via `install.sh`

---

## Requirements

Ensure the following are installed:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/) (v2+)
- [Docker Build](https://docs.docker.com/build/)
- [PHP ≥ 8.3](https://www.php.net/)
- [Composer 2.7+](https://getcomposer.org/)
- Unix-based system (Linux/macOS)

---

## Project Structure


```
├── Caddyfile # Caddy reverse proxy config
├── Dockerfile # Apache + PHP + extensions
├── docker-compose.yml # Container definitions
├── .env # Project environment variables
├── .env.example # Template for .env
├── apache2.conf # Apache vhost config
├── install.sh # Setup script
└── wp/
    ├── public/ # WordPress core (composer-managed)
    ├── vendor/ # Composer dependencies
    └── wp-content/ # Your custom themes/plugins
```
---

## Getting Started

### 1. Clone the Repository

#### you should fork the repo so you have your own copy of it you can modify

```
git clone https://github.com/IngoGutwin/wordpress-boilerplate.git
```

###### Make sure to adjust the following files according to your project: 
 - .env
 - docker-compose.yml
 - docker-compose.caddy.yml
 - docker/Caddyfile
 - docker/apache2.conf


#### rename it

```
bash
mv wordpress-boilerplate your-project-name
```

---

### 2. Copy and Edit the Environment File

```
bash
cd your-project-name
cp .env.example .env
```

---

##### Then open .env, docker-compose, Caddyfile, apache2.conf in a text editor and set your project-specific values!!!

---

### 3. Remove the .git folder and init your own repo

```
bash
rm -rf .git
git init
```

---

##### Open these files in a text editor and set your project-specific values!!!

 - .env
 - docker-compose.yml
 - docker-compose.caddy.yml
 - docker/Caddyfile
 - docker/apache2.conf

---

### 3. Add Local Domain to Hosts File

###### Edit your /etc/hosts file:

```
sudo nano /etc/hosts
```
Add this line:
```
127.0.0.1 your-domain.test
```
Replace the domain with the one you set in .env.

---

### 4. Run the Setup Script

Run the provided installer:

```
sudo chmod +x install.sh
./install.sh
```
What it does:

Runs composer install

Moves the wp-content folder to the correct location (due to a known quirk in johnpbloch/wordpress)

Builds the custom Docker image

Starts all Docker containers (PHP, MySQL, Caddy)

After the setup, your site should be available at:

http://your-domain.test

#### If not, make sure:

The container container_dev_reverse_proxy (Caddy) is running

Your /etc/hosts entry is correct

---
