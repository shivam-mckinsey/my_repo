#!/bin/bash

# Location to place backups.
backup_dir="/var/pgdump/"

#String to append to the name of the backup files
backup_date=`date +%Y-%m-%d_%H-%M`

#Numbers of days you want to keep copie of your databases
number_of_days=30
databases=`psql -l -t | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`
for i in $databases; do
  if [ "$i" != "template0" ] && [ "$i" != "template1" ] && [ "$i" != "postgres" ]; then
    backupfile=$backup_dir$i.$backup_date.sql.gz
    echo Dumping $i to $backupfile
    pg_dump $i|gzip > $backupfile
  fi
done
find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;
