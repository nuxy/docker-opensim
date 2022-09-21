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

CREATE DATABASE opensim
EOF

# Check for existing database.
if [ -s /tmp/opensim.sql ]; then

    # Import and remove.
    mysql opensim < /tmp/opensim.sql
    rm /tmp/opensim.sql
fi

mysqladmin reload

# Update application config.
CONFIG_BLOCK=$(cat << EOF
[DatabaseService]
    StorageProvider = "OpenSim.Data.MySQL.dll"
    ConnectionString = "Data Source=localhost;Database=opensim;User ID=opensim;Password=$OPENSIM_PASSWORD;Old Guids=true;SslMode=None;"

[Hypergrid]
EOF
)

perl -0 -i -pe "s/\[DatabaseService\].*^\[Hypergrid\]/$CONFIG_BLOCK/ms" /usr/games/config-include/StandaloneCommon.ini

# Start the OpenSim server.
service grid-server start
