<?php
require __DIR__ . '/vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable( __DIR__ );
$dotenv->safeLoad();

/**
 * Read a string environment variable.
 */
function env( string $name, ?string $default_value = '' ): ?string {
	$value = $_ENV[ $name ] ?? $_SERVER[ $name ] ?? null;

	return is_string( $value ) ? $value : $default_value;
}

/**
 * Read a boolean environment variable safely.
 *
 * Accepts true/false, 1/0, yes/no and on/off.
 * Invalid or missing values use the specified default_boolean.
 *
 * @name            string
 * @default_boolean boolean
 */
function env_bool( string $name, bool $default_value = false ): bool {
	$value = getenv( $name );

	if ( false === $value || '' === $value ) {
		return $default_value;
	}

	$parsed = filter_var(
		$value,
		FILTER_VALIDATE_BOOLEAN,
		FILTER_NULL_ON_FAILURE
	);

	return null === $parsed ? $default_value : $parsed;
}

define( 'COOKIE_API_URL', env( 'COOKIE_API_URL' ) );

define( 'WP_ENVIRONMENT', env( 'WP_ENVIRONMENT' ) );

/**
 * Database name
 */
define( 'DB_NAME', env( 'DATABASE_NAME' ) );

/**
 * Database user
 */
define( 'DB_USER', env( 'DATABASE_USER' ) );

/**
 * Database user password
 */
define( 'DB_PASSWORD', env( 'DATABASE_PASSWORD' ) );

/**
 * Database host
 */
define( 'DB_HOST', env( 'DATABASE_HOST' ) );

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
define( 'WP_HOME', env( 'WP_SITEURL' ) );
/**
 * WordPress site URL (which is for the admin)
 */
define( 'WP_SITEURL', env( 'WP_SITEURL' ) . '/wordpress' );

/**
 * WordPress content directory
 */
define( 'WP_CONTENT_DIR', __DIR__ . '/public/wp-content' );

/**
 * WordPress content directory url
 */
define( 'WP_CONTENT_URL', WP_SITEURL . '/wp-content' );
/**
 * WordPress plugins directory
 */
define( 'WP_PLUGIN_DIR', WP_CONTENT_DIR . '/plugins' );

/**
 * Controls the error reporting. When true, it sets the error reporting level
 * to E_ALL.
 */
define( 'WP_DEBUG', env_bool( 'WP_DEBUG', false ) );

/**
 * If error logging is enabled, this determines whether the error
 * is logged or not in the debug.log file inside /wp-content.
 */
define( 'WP_DEBUG_LOG', env_bool( 'WP_DEBUG_LOG', false ) );

define( 'WP_CACHE', env_bool( 'WP_CACHE', false ) );

/**
 * If error logging is enabled, this determines whether the error is
 * shown on the site (in-browser)
 */
define( 'WP_DEBUG_DISPLAY', env_bool( 'WP_DEBUG_DISPLAY', false ) );
/**
 * This disables live edits of theme and plugin files on the WordPress
 * administration area. It also prevents users from adding,
 * updating and deleting themes and plugins.
 */
define( 'DISALLOW_FILE_MODS', env_bool( 'DISALLOW_FILE_MODS', false ) );

/**
 * Prevents WordPress core updates, as this is controlled through
 * Composer.
 */
define( 'WP_AUTO_UPDATE_CORE', env_bool( 'WP_AUTO_UPDATE_CORE', false ) );

$table_prefix = env( 'WP_TABLE_PREFIX' );

define( 'AUTH_KEY', env( 'AUTH_KEY' ) );
define( 'SECURE_AUTH_KEY', env( 'SECURE_AUTH_KEY' ) );
define( 'LOGGED_IN_KEY', env( 'LOGGED_IN_KEY' ) );
define( 'NONCE_KEY', env( 'NONCE_KEY' ) );
define( 'AUTH_SALT', env( 'AUTH_SALT' ) );
define( 'SECURE_AUTH_SALT', env( 'SECURE_AUTH_SALT' ) );
define( 'LOGGED_IN_SALT', env( 'LOGGED_IN_SALT' ) );
define( 'NONCE_SALT', env( 'NONCE_SALT' ) );


require_once ABSPATH . 'wp-settings.php';
