<?php

/* Local configuration for Roundcube Webmail */

// ----------------------------------
// SQL DATABASE
// ----------------------------------
// Database connection string (DSN) for read+write operations
$config['db_dsnw'] = 'mysql://postfix:postfix_pass@database-container/postfix';

// Table prefix for Roundcube tables
$config['db_prefix'] = '';

// ----------------------------------
// LOGGING
// ----------------------------------
// Logging driver: 'syslog', 'stdout', 'file' or null
$config['log_driver'] = 'file';

// Directory for storing log files (must be writeable for webserver)
$config['log_dir'] = '/var/www/html/logs/';

// Syslog facility to use, if using the 'syslog' log driver
$config['syslog_facility'] = LOG_MAIL;

// Log identification string to use for syslog driver
$config['syslog_id'] = 'roundcube';

// ----------------------------------
// IMAP
// ----------------------------------
// The IMAP host chosen to perform the log-in
$config['default_host'] = 'dovecot';

// TCP port used for IMAP connections
$config['default_port'] = 143;

// Automatically add this domain to user names for login
// Using Punycode for Cyrillic domain compatibility
$config['username_domain'] = 'xn----7sbbh1akdldfh0ch.xn--p1ai';

// Automatically create a new Roundcube user when log-in the first time
$config['auto_create_user'] = true;

// Store sent messages in this folder
$config['sent_mbox'] = 'Sent';

// Move messages to this folder when deleting them
$config['trash_mbox'] = 'Trash';

// Store draft messages in this folder
$config['drafts_mbox'] = 'Drafts';

// Store spam messages in this folder
$config['junk_mbox'] = 'Junk';

// ----------------------------------
// SMTP
// ----------------------------------
// SMTP server host (for sending mails)
$config['smtp_server'] = 'postfix';

// SMTP port
$config['smtp_port'] = 587;

// Use current IMAP username and password for SMTP authentication
$config['smtp_user'] = '%u';
$config['smtp_pass'] = '%p';

// Log sent messages in log_dir/sendmail or to syslog
$config['smtp_log'] = true;

// ----------------------------------
// SYSTEM
// ----------------------------------
// Provide URL where a user can get support for this Roundcube installation
$config['support_url'] = 'mailto:admin@xn----7sbbh1akdldfh0ch.xn--p1ai';

// Name your service. This is displayed on the login screen and in the window title
$config['product_name'] = 'FltrWebmail';

// Use this folder to store temp files (must be writeable for webserver)
$config['temp_dir'] = '/var/www/html/temp/';

// This key is used for encrypting purposes, like storing of imap password
$config['des_key'] = 'MKXB3PukpBKj6mSYZEN4An5Y';

// Check client IP in session authorization
$config['ip_check'] = true;

// Enable spellchecker
$config['enable_spellcheck'] = true;

// Spellcheck engine
$config['spellcheck_engine'] = 'googie';

// Set identities access level:
// 2 - one identity with possibility to edit all params
$config['identities_level'] = 2;

// ----------------------------------
// USER INTERFACE
// ----------------------------------
// The default locale setting (leave empty for auto-detection)
$config['language'] = 'ru_RU';

// Skin name: folder from skins/
$config['skin'] = 'elastic';

// Show up to X items in the mail messages list view
$config['mail_pagesize'] = 50;

// Show up to X items in the contacts list view
$config['addressbook_pagesize'] = 50;

// Prefer displaying HTML messages
$config['prefer_html'] = true;

// Compose html formatted messages by default
// 1 - always
$config['htmleditor'] = 1;

// Save compose message every X minutes
$config['draft_autosave'] = 300;

// Behavior if a received message requests a message delivery notification (read receipt)
$config['mdn_requests'] = 0;

// How to encode attachment long/non-ascii names
$config['mime_param_folding'] = 1;

// ----------------------------------
// SECURITY
// ----------------------------------
// Enforce connections over https
// $config['force_https'] = true;

// Use secure flag for session cookies
$config['session_auth_name'] = 'roundcube_sessauth';

// Session domain
// $config['session_domain'] = '.эксперты-1с.рф';

// ----------------------------------
// PLUGINS
// ----------------------------------
// List of active plugins (in plugins/ directory)
$config['plugins'] = [
    'archive',
    'attachment_reminder', 
    'emoticons',
    'enigma',
    'fetchmail',
    'filters',
    'help',
    'hide_blockquote',
    'newmail_notifier',
    'password',
    'persistent_login',
    'reconnect',
    'userinfo',
    'zipdownload'
];

// ----------------------------------
// FETCHMAIL PLUGIN CONFIG
// ----------------------------------
// Enable fetchmail plugin
$config['fetchmail_enabled'] = true;
