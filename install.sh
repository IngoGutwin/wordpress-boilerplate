#!/bin/bash

set -euo pipefail

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

WP_CONTENT_SOURCE="wp/public/wordpress/wp-content"
WP_CONTENT_TARGET="wp/public/wp-content"

check_dependencies() {
    for cmd in composer docker docker-compose; do
        if ! command -v "$cmd" >/dev/null 2>&1; then 
            echo -e "${RED}❌ $cmd not found. Please install it first.${RESET}"
            return 1
        fi 
    done
    return 0
}

do_composer_install() {
    echo -e "${GREEN}Starting composer install...${RESET}"
    cd wp
    composer install
    cd ..
}

move_wp_content_folder() {
    if [ "$WP_CONTENT_SOURCE" ]; then
        if [ ! -d "$WP_CONTENT_TARGET" ]; then
            echo -e "${GREEN}Moving wp-content to target...${RESET}"
            if mv "$WP_CONTENT_SOURCE" "$WP_CONTENT_TARGET"; then
                echo -e "${GREEN}Moved wp-content successfully.${RESET}"
            else
                echo -e "${RED}Failed to move wp-content.${RESET}"
                exit 1
            fi
        else
            echo -e "${RED}Target directory $WP_CONTENT_TARGET already exists. Skipping move.${RESET}${RESET}"
        fi
    else
        echo -e "${RED}Source directory $WP_CONTENT_SOURCE not found. Skipping move.${RESET}"
    fi
}

detect_web_group() {
    if getent group http > /dev/null; then
        echo "http"
    elif getent group www-data > /dev/null; then
        echo "www-data"
    else
        echo "no weg group" >&2
        return 1
    fi

}

set_wp_permissions() {
    WEB_GROUP=$(detect_web_group) || exit 1
    echo "$WEB_GROUP"
    local wp_path="wp/public"

    echo "change group to http or www-data $wp_path ..."
    sudo chgrp -R $WEB_GROUP "$wp_path"

    echo "chmod to 775 ..."
    sudo find "$wp_path" -type d -exec chmod 775 {} \;

    echo "chmod to 664 ..."
    sudo find "$wp_path" -type f -exec chmod 664 {} \;

    echo "Set setgid-Bit for derectories ..."
    sudo find "$wp_path" -type d -exec chmod g+s {} \;

    echo "permissions ready!"
}

build_image_and_start_containers() {
    echo -e "${GREEN}Starting docker-compose...${RESET}"
    docker-compose up -d --build

    echo -e "${GREEN}Setup ready! Open your SITE_URL in your browser.${RESET}"
}

if [ check_dependencies ]; then
#    do_composer_install
#    move_wp_content_folder
#    build_image_and_start_containers
    set_wp_permissions
fi

