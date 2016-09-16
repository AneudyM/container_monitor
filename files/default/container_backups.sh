#!/bin/bash

# Path to Apache and MySQL data directories
HTTPD_DATA="/opt/container_monitor/www"
MYSQLD_DATA="/opt/container_monitor/db"

# Store current date
now=$(date +"%F")

# The target backup path
backup_dir="/opt/container_monitor/backups/$now"

# Backup filename hostname.time.tar.gz
afile="httpd-container.$(date +'%T').tar.gz"
mfile="mysqld-container.$(date +'%T').sql.gz"

# Set MySQL username and password
MYSQLUSER="root"
MYSQLPASSWORD="yourpassword"

# Verify the backup buffer directory exists
[ ! -d $backup_dir ] && mkdir -p ${backup_dir}

# Log the backup initialization time in the /var/log/messages
logger "$0: *** Backup started @ $(date) ***"

# Backup the webserver directory
tar -zcvf ${backup_dir}/${afile} "${HTTPD_DATA}"

# Backup MySQL
mysqldump -h 127.0.0.1 \
          -P 49222 \
          -u${MYSQLUSER} \
          -p${MYSQLPASSWORD} \
          --all-databases | gzip -9 > ${backup_dir}/${mfile};

# Log backup finalization time in /var/log/messages
logger "$0: *** Backup Ended @ $(date) ***"
