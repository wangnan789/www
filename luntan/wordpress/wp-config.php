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
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'cws-www' );

/** Database username */
define( 'DB_USER', 'root' );

/** Database password */
define( 'DB_PASSWORD', 'qweasd' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

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
define( 'AUTH_KEY',         'iMkA|J T2P|-mPvWw8Hpr&,qqP&5Y8*b(9N:YG;i!}1`$|m{jgiB^jJSDE&xyg%I' );
define( 'SECURE_AUTH_KEY',  '_gN+X.2sB;<bp@p :E)R#R+XuG;AaUOE.m-EdW^]1 5>6_GT9{|VZibf[Ux-N;$>' );
define( 'LOGGED_IN_KEY',    'tz5yWPY[i+ljF!LAR4*:mX./sYA_(0r. 8vmB>1j?quzz%cfrHu3wk}j892#I.dJ' );
define( 'NONCE_KEY',        ';P6J$7PzgO9^p$8*jx{yR0p+&Mj-^lq#MZ(S.&o^t8jFFH%es30{#TDbe=OMBE9v' );
define( 'AUTH_SALT',        'xpWJX3l<4H_0NnV4Wx$9MNMTv>G[D0m 4ea5f*;K=ri|c5R8[Wnk<:{wMx`Uwn0<' );
define( 'SECURE_AUTH_SALT', 'Pt=YZ|U-w-Fkg&4p3]y1Op(B:wZ]i|+!*[LmgV2E~wv{0~`vC=L[=h0<a.4Br{=`' );
define( 'LOGGED_IN_SALT',   'AAM.syd)iY^!VS:1+.[<9*T.e{H2U8`])N{8q_(!7j<D+]$g&L7;68z=0QSa=Y4&' );
define( 'NONCE_SALT',       '.OX[Cy0/_?Ke=o;(%~-AcM3U?>74uiX@rx[;4:,?qYDR_Ruhzn9$@w[h,Lsix(4C' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'www';

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
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
