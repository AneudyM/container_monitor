#!/bin/sh

passHash=`sudo openssl passwd -1 yourpassword`;
echo "USE icingaweb2;\nINSERT INTO icingaweb_user (name, active, password_hash) VALUES ('icingaadmin', 1, '$passHash');" > /opt/container_monitor/db_scripts/create_icingaweb2_db_user.sql

