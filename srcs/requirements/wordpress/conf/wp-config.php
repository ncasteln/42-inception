<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wp_database' );

/** Database username */
define( 'DB_USER', 'myuser' );

/** Database password */
define( 'DB_PASSWORD', 'mypassword' );

/** Database hostname */
define( 'DB_HOST', 'mariadb:3306' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'Cbi5Nv )rOWC-J]ErHb+r,blCP>X|AcU6BE8Q9T8$Ms5B jNt6FbXuZ!(fR4_Xc*' );
define( 'SECURE_AUTH_KEY',   ',!ZjaB_Q2+],,7NdeSY<;_N;NuOXg+ @_v^(bp3.q{s+UL{qkvn;z@O_ak.CTjN&' );
define( 'LOGGED_IN_KEY',     '7jp@`R:/=^%kYC]Ed#aN~u6x-LnJoa1pRC/15owwzc!,{TjF_P(W}K2U]QK]J:X|' );
define( 'NONCE_KEY',         'z4|WcTa%={*D#W{jMj&o<BM$kAW,N_M&:Vg]i;0F!AN|RN8>Hd%nrMjjUybP1dCb' );
define( 'AUTH_SALT',         '[)=s%*75G;32tD]%@[?d=k+{{DF$E87:]mC{}zJ425qzK_B^xVN5Yk1ARP#N(?]2' );
define( 'SECURE_AUTH_SALT',  'c64@Vn.!IE^_wv3xb=5m_:.8~rdeugbxcdd]bAHF#Tv( FLqqGtLS7%{5u}X?2RL' );
define( 'LOGGED_IN_SALT',    '1?x B=K!Y,4Z]GHg.>.?K]0.>>%-Mj,4aj$oyO%fm>!d2qR1351(Z#@tM3_d7Ve:' );
define( 'NONCE_SALT',        'yn/ua5?k $;&.RPc+3UPv=kYZ@W[LtWr]UGDx*v,}/{sQXa;u{Mx|C,{nA?[)AWN' );
define( 'WP_CACHE_KEY_SALT', ',9;8ysx=Tj}9&Q8=hZ!v)&IU4;y,BTI$C;up]GL4Lb#+ge``%%.R<Ijm01(U!&<A' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
        define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';