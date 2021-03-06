#!/bin/bash

# Update list of available packages

echo 'Fetching updated list of available packages'
apt-get update
echo 'Done'

# Somebody missed essential packages

echo 'Fetching and installing essential log packages'
apt-get install syslog-ng logrotate -y
echo 'Done'

# Lets install mysql-server in silent mode
echo 'Mysql server installation'
DEBIAN_FRONTEND=noninteractive apt-get install mysql-server -y
echo 'Done'

# Generate mysql password
echo 'Generating mysql root pass'
PASS=$(head -c 500 /dev/urandom | tr -dc a-z0-9A-Z | head -c 16)
echo 'Done'

# Setting up root pass for mysql
echo 'Setting up root mysql pass'
mysqladmin -u root password $PASS
echo 'Done'

echo '*****************************************************'
echo
echo 'ALL DONE!'
echo 'Your mysql root password is: '"$PASS"
echo
echo '*****************************************************'
