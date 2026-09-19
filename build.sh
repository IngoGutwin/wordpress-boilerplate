#!/bin/bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
THEME_DIR="$PROJECT_ROOT/wp/public/wp-content/themes/a_m_theme"

copy_plugin_files() {
    echo "copy plugins"
    cp -r "wp/public/wp-content/mu-plugins" "$BUILD_DIR/public/wp-content"
    cp -r "wp/public/wp-content/plugins" "$BUILD_DIR/public/wp-content"
}

build_theme() {
    echo "building theme"
    cd "$THEME_DIR"
    bash ./build.sh
    cp -r "build/." "$BUILD_DIR/public/wp-content/themes/a_m_theme/"
    cd "$PROJECT_ROOT"
}

copy_wp_files() {
    echo "copy wordpress files"
    cp "wp/app.php" "$BUILD_DIR"
    cp "wp/public/index.php" "$BUILD_DIR/public/"
    cp "wp/public/wp-config.php" "$BUILD_DIR/public/" 
    cp -r "wp/public/wordpress" "$BUILD_DIR/public/"
    cp -r "wp/vendor" "$BUILD_DIR/"
}

create_folder_structur() {
    echo "building folder structure"
    mkdir -p "build"
    mkdir -p "build/public"
    mkdir -p "build/public/wp-content/themes/a_m_theme"
}

install_dependencies() {
    echo "intalling wordpress dependencies"
    cd "$PROJECT_ROOT/wp"
    composer install --no-dev --prefer-dist --optimize-autoloader
    cd "$PROJECT_ROOT"
}

run_script() {
    echo "building wordpress"
    install_dependencies
    create_folder_structur
    copy_wp_files
    build_theme
    copy_plugin_files
}

if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
    run_script
else
    run_script
fi

echo "building proccess finished!"
