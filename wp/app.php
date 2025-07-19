<?php
require __DIR__ . '/vendor/autoload.php';

define('WP_ENVIRONMENT', $_ENV['WP_ENVIRONMENT']);

/**
 * Database name
 */
define('DB_NAME', $_ENV['DATABASE_NAME']);

/**
 * Database user
 */
define('DB_USER', $_ENV['DATABASE_USER']);

/**
 * Database user password
 */
define('DB_PASSWORD', $_ENV['DATABASE_PASSWORD']);

/**
 * Database host
 */
define('DB_HOST', $_ENV['DATABASE_HOST']);

/**
 * WordPress DB Charset (is setup this way when the tables are made)
 */
define( 'DB_CHARSET', 'utf8' );

/**
 * WordPress DB Collation (is setup this way when the tables are made)
 */
define( 'DB_COLLATE', 'utf8_general_ci' );

/**
 * WordPress home URL (for the front-of-site)
 */
define('WP_HOME', $_ENV['WP_SITEURL']);
/**
 * WordPress site URL (which is for the admin)
 */
define('WP_SITEURL', $_ENV['WP_SITEURL'] . '/wordpress');

/**
 * WordPress content directory
 */
define('WP_CONTENT_DIR', dirname(__FILE__) . '/public/wp-content');

/**
 * WordPress content directory url
 */
define( 'WP_CONTENT_URL', $_ENV['WP_SITEURL'] . '/wp-content' );
/**
 * WordPress plugins directory
 */
define('WP_PLUGIN_DIR', WP_CONTENT_DIR . '/plugins');

/**
 * Controls the error reporting. When true, it sets the error reporting level
 * to E_ALL. 
 */
define( 'WP_DEBUG', $_ENV['WP_DEBUG'] );

/**
 * If error logging is enabled, this determines whether the error
 * is logged or not in the debug.log file inside /wp-content.
 */
define( 'WP_DEBUG_LOG', $_ENV['WP_DEBUG_LOG'] );

/**
 * If error logging is enabled, this determines whether the error is
 * shown on the site (in-browser)
 */
define( 'WP_DEBUG_DISPLAY', $_ENV['WP_DEBUG_DISPLAY'] );
/**
 * This disables live edits of theme and plugin files on the WordPress
 * administration area. It also prevents users from adding, 
 * updating and deleting themes and plugins.
 */
define( 'DISALLOW_FILE_MODS', $_ENV['DISALLOW_FILE_MODS'] );

/**
 * Prevents WordPress core updates, as this is controlled through
 * Composer.
 */
define( 'WP_AUTO_UPDATE_CORE', $_ENV['WP_AUTO_UPDATE_CORE'] );

$table_prefix = $_ENV['WP_TABLE_PREFIX'];

define('AUTH_KEY', $_ENV['AUTH_KEY']);
define('SECURE_AUTH_KEY', $_ENV['SECURE_AUTH_KEY']);
define('LOGGED_IN_KEY', $_ENV['LOGGED_IN_KEY']);
define('NONCE_KEY', $_ENV['NONCE_KEY']);
define('AUTH_SALT', $_ENV['AUTH_SALT']);
define('SECURE_AUTH_SALT', $_ENV['SECURE_AUTH_SALT']);
define('LOGGED_IN_SALT', $_ENV['LOGGED_IN_SALT']);
define('NONCE_SALT', $_ENV['NONCE_SALT']);


require_once(ABSPATH . 'wp-settings.php');