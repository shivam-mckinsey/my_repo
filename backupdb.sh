# Backup script starts here.

 #!/bin/bash
 # Location of the backup logfile.
 logfile="/var/log/postgresql/logfile.log"

 # Location to place backups.
 backup_dir="/var/pgdump"

 touch $logfile
 timeslot=`date +%d%m%y%H%M%S`
 databases=`psql -U postgres -q -c "\l" | awk '{ print $1}' | grep -vE '^\||^-|^List|^Name|template[0|1]|^\('`

  for i in $databases; do
    timeinfo=`date '+%T %x'`
    echo "Backup and Vacuum started at $timeinfo for time slot $timeslot on database: $i " >>
    $logfile
    /usr/bin/vacuumdb -z -U postgres $i >/dev/null 2>&1
    /usr/bin/pg_dump $i -U postgres | gzip > "$backup_dir/openerp-$i-$timeslot-database.gz"
    timeinfo=`date '+%T %x'`
    echo "Backup and Vacuum complete at $timeinfo for time slot $timeslot on database: $i " >> $logfile
 done

 #-------------------------------------------------

 # delete files more than 10 days old
 find $backup_dir/openerp* -mtime +10 -exec rm {} \;
