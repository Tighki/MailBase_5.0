-- Create postfix database and user
CREATE DATABASE IF NOT EXISTS postfix;
CREATE USER IF NOT EXISTS 'postfix'@'%' IDENTIFIED BY 'postfix_pass';
GRANT ALL PRIVILEGES ON postfix.* TO 'postfix'@'%';
FLUSH PRIVILEGES;

USE postfix;

-- Create tables for Postfix/Dovecot/Postfixadmin
CREATE TABLE IF NOT EXISTS admin (
  username varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  created datetime NOT NULL default '2000-01-01 00:00:00',
  modified datetime NOT NULL default '2000-01-01 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS alias (
  address varchar(255) NOT NULL,
  goto text NOT NULL,
  domain varchar(255) NOT NULL,
  created datetime NOT NULL default '2000-01-01 00:00:00',
  modified datetime NOT NULL default '2000-01-01 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY (address),
  KEY domain (domain)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS alias_domain (
  alias_domain varchar(255) NOT NULL,
  target_domain varchar(255) NOT NULL,
  created datetime NOT NULL default '2000-01-01 00:00:00',
  modified datetime NOT NULL default '2000-01-01 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY (alias_domain),
  KEY active (active),
  KEY target_domain (target_domain)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS domain (
  domain varchar(255) NOT NULL,
  description varchar(255) CHARACTER SET utf8 NOT NULL,
  aliases int(10) NOT NULL default '0',
  mailboxes int(10) NOT NULL default '0',
  maxquota bigint(20) NOT NULL default '0',
  quota bigint(20) NOT NULL default '0',
  transport varchar(255) NOT NULL default 'virtual',
  backupmx tinyint(1) NOT NULL default '0',
  created datetime NOT NULL default '2000-01-01 00:00:00',
  modified datetime NOT NULL default '2000-01-01 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY (domain)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS domain_admins (
  username varchar(255) NOT NULL,
  domain varchar(255) NOT NULL,
  created datetime NOT NULL default '2000-01-01 00:00:00',
  active tinyint(1) NOT NULL default '1',
  KEY username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS fetchmail (
  id int(11) unsigned NOT NULL auto_increment,
  mailbox varchar(255) NOT NULL,
  src_server varchar(255) NOT NULL,
  src_auth enum('password','kerberos_v5','kerberos','kerberos_v4','gssapi','cram-md5','otp','ntlm','msn','ssh','any') NOT NULL default 'password',
  src_user varchar(255) NOT NULL,
  src_password varchar(255) NOT NULL,
  src_folder varchar(255) NOT NULL,
  poll_time int(11) unsigned NOT NULL default '10',
  fetchall tinyint(1) unsigned NOT NULL default '0',
  keep tinyint(1) unsigned NOT NULL default '0',
  protocol enum('POP3','IMAP','POP2','ETRN','AUTO') NOT NULL default 'POP3',
  usessl tinyint(1) unsigned NOT NULL default '0',
  extra_options text,
  returned_text text,
  mda varchar(255) NOT NULL default '',
  date timestamp NOT NULL default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS log (
  timestamp datetime NOT NULL default '2000-01-01 00:00:00',
  username varchar(255) NOT NULL,
  domain varchar(255) NOT NULL,
  action varchar(255) NOT NULL,
  data text NOT NULL,
  KEY timestamp (timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS mailbox (
  username varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  name varchar(255) CHARACTER SET utf8 NOT NULL,
  maildir varchar(255) NOT NULL,
  quota bigint(20) NOT NULL default '0',
  local_part varchar(255) NOT NULL,
  domain varchar(255) NOT NULL,
  created datetime NOT NULL default '2000-01-01 00:00:00',
  modified datetime NOT NULL default '2000-01-01 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY (username),
  KEY domain (domain)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS quota (
  username varchar(255) NOT NULL,
  path varchar(100) NOT NULL,
  current bigint(20) NOT NULL default 0,
  PRIMARY KEY (username,path)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS quota2 (
  username varchar(100) NOT NULL,
  bytes bigint(20) NOT NULL default 0,
  messages int(11) NOT NULL default 0,
  PRIMARY KEY (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS vacation (
  email varchar(255) NOT NULL,
  subject varchar(255) CHARACTER SET utf8 NOT NULL,
  body text CHARACTER SET utf8 NOT NULL,
  cache text NOT NULL,
  domain varchar(255) NOT NULL,
  created datetime NOT NULL default '2000-01-01 00:00:00',
  active tinyint(1) NOT NULL default '1',
  PRIMARY KEY (email),
  KEY email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS vacation_notification (
  on_vacation varchar(255) NOT NULL,
  notified varchar(255) NOT NULL,
  notified_at timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY (on_vacation,notified),
  CONSTRAINT vacation_notification_pkey FOREIGN KEY (on_vacation) REFERENCES vacation(email) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insert a test domain
INSERT INTO domain (domain, description, aliases, mailboxes, maxquota, quota, transport, backupmx, created, modified, active) 
VALUES ('fltrktv.ru', 'Main domain', 0, 0, 0, 0, 'virtual', 0, NOW(), NOW(), 1);

-- Create admin user for postfixadmin (password: admin123)
INSERT INTO admin (username, password, created, modified, active) 
VALUES ('admin@fltrktv.ru', '$1$e7ce2a1d$E2ZQP8ow0qqM1F6.QT.C51', NOW(), NOW(), 1); 