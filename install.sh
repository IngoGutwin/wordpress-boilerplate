#!/bin/bash

set -euo pipefail

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

for cmd in composer docker docker-compose; do
  command -v $cmd >/dev/null 2>&1 || { echo -e "${RED}❌ $cmd not found. Please install it first.${RESET}"; exit 1; }
done

echo -e "${GREEN}Starting composer install...${RESET}"
cd wp
composer install
cd ..

WP_CONTENT_SOURCE="wp/public/wordpress/wp-content"
WP_CONTENT_TARGET="wp/public/wp-content"

if [ -d "$WP_CONTENT_SOURCE" ]; then
  if [ ! -d "$WP_CONTENT_TARGET" ]; then
    echo -e "${GREEN}Moving wp-content to target...${RESET}"
    if mv "$WP_CONTENT_SOURCE" "$WP_CONTENT_TARGET"; then
      echo -e "${GREEN}Moved wp-content successfully.${RESET}"
    else
      echo -e "${RED}Failed to move wp-content.${RESET}"
      exit 1
    fi
  else
    echo -e "${RED}Target directory $WP_CONTENT_TARGET already exists. Skipping move.${RESET}"
  fi
else
  echo -e "${RED}Source directory $WP_CONTENT_SOURCE not found. Skipping move.${RESET}"
fi

echo -e "${GREEN}Starting docker-compose...${RESET}"
docker-compose up -d --build

echo -e "${GREEN}Setup ready! Open ${WP_SITEURL} in your browser.${RESET}"