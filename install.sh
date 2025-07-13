#!/bin/bash

set -e

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN} start composer install..."

cd wp

composer install

cd ..

WP_CONTENT_SOURCE="wp/public/wordpress/wp-content"
WP_CONTENT_TARGET="wp/public/wp-content"

if [ -d "$WP_CONTENT_SOURCE" ]; then
  if [ ! -d "$WP_CONTENT_TARGET" ]; then
    echo -e "${GREEN} move wp-content to target...${RESET}"
    mv "$WP_CONTENT_SOURCE" "$WP_CONTENT_TARGET"
  else
    echo -e "${RED} target-dir $WP_CONTENT_TARGET already exists. moving skipped.${RESET}"
  fi
else
  echo -e "${RED} wp-content source $WP_CONTENT_SOURCE not found. skip move.${RESET}"
fi

# load .evn File 
if [ -f ".env" ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "❌ .env-File not found!"
  exit 1
fi

echo -e "${GREEN} building the docker image...${RESET}"
# change the image name to your needs
docker build -t "your-wp-apache2-image-build" .

echo -e "${GREEN} starting with docker-compose...${RESET}"
docker-compose up -d

echo -e "${GREEN} Setup ready! Open ${WP_SITEURL} in your Browser.${RESET}"
