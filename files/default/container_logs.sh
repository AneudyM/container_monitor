#!/bin/bash

config_dir="/opt/container_monitor/etc"
[ ! -d $config_dir ] && mkdir -p ${config_dir}
timestamp=$(date +'%Y-%m-%dT%H:%M:%S');
timeFile="timestamp.conf"
currTime=$(date +'%H%M%S');
GETLOGS="sudo docker logs --timestamps --since"
now=$(date +"%F");
logs_dir="/opt/container_monitor/logs/$now"
HTTPD_CONTAINER_LOGS="${logs_dir}/httpd"
[ ! -d $HTTPD_CONTAINER_LOGS ] && mkdir -p ${HTTPD_CONTAINER_LOGS}
MYSQLD_CONTAINER_LOGS="${logs_dir}/mysqld"
[ ! -d $MYSQLD_CONTAINER_LOGS ] && mkdir -p ${MYSQLD_CONTAINER_LOGS}
archived_dir="/opt/container_monitor/archived/$now"
[ ! -d $archived_dir ] && mkdir -p ${archived_dir}
HTTPD_ARCHIVED="${archived_dir}/httpd"
[ ! -d $HTTPD_ARCHIVED ] && mkdir -p ${HTTPD_ARCHIVED}
MYSQLD_ARCHIVED="${archived_dir}/mysqld"
[ ! -d $MYSQLD_ARCHIVED ] && mkdir -p ${MYSQLD_ARCHIVED}
httpdOutLogFile="httpd-container.${currTime}.out"
httpdErrLogFile="httpd-container.${currTime}.err"
mysqldOutLogFile="mysqld-container.${currTime}.out"
mysqldErrLogFile="mysqld-container.${currTime}.err"
httpd_archive="httpd-container.${currTime}.tar"
mysqld_archive="mysqld-container.${currTime}.tar"


#******MAIN********
time_from_file=$(cat ${config_dir}/${timeFile});
# Get the logs from the containers
$GETLOGS=${time_from_file} httpd-container > ${HTTPD_CONTAINER_LOGS}/${httpdOutLogFile} \
                                2> ${HTTPD_CONTAINER_LOGS}/${httpdErrLogFile};

$GETLOGS=${time_from_file} mysqld-container > ${MYSQLD_CONTAINER_LOGS}/${mysqldOutLogFile} \
                                2> ${MYSQLD_CONTAINER_LOGS}/${mysqldErrLogFile}; 

# Archive the above generated logs
cd ${HTTPD_CONTAINER_LOGS};
tar -cf ${HTTPD_ARCHIVED}/${httpd_archive}  "${httpdOutLogFile}" "${httpdErrLogFile}";
cd ${MYSQLD_CONTAINER_LOGS};
tar -cf ${MYSQLD_ARCHIVED}/${mysqld_archive} "${mysqldOutLogFile}" "${mysqldErrLogFile}";


# SAVE THE TIMESTAMP FOR LATER USE
echo $timestamp > ${config_dir}/${timeFile}
