#!/bin/sh

DEFAULT_PASSWORD=`openssl rand -hex 12`
OPENSIM_PASSWORD=`openssl rand -hex 12`

# Configure database (first-boot).
service mysql start

mysql -fsu root << EOF
USE mysql;

-- Restrict root access.
UPDATE user SET Password = PASSWORD('$DEFAULT_PASSWORD') WHERE User = 'root';

-- Create user/database.
CREATE USER 'opensim'@'localhost' IDENTIFIED BY '$OPENSIM_PASSWORD';
GRANT ALL PRIVILEGES ON opensim.* TO 'opensim'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

CREATE DATABASE opensim
EOF

# Update application config.
sed -i "s/@@PASSWORD@@/$OPENSIM_PASSWORD/g" /usr/games/config-include/StandaloneCommon.ini

# Start the OpenSim server.
service grid-server start

# Keep-alive
sleep infinity
