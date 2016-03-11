#!/bin/sh    
hostname=`grafentee`

##########################################
## OpenERP Backup
## Backup databases: Grafen-Tee-LIVE ACONI
##########################################

# Stop OpenERP Server
/etc/init.d/odoo-server stop

# Dump DBs
for db in Grafen-Tee-LIVE
do
  date=`date +"%Y%m%d_%H%M%N"`
  filename="/var/pgdump/${hostname}_${db}_${date}.sql"
  pg_dump -E UTF-8 -p 5432 -F p -b -f $filename $db
  gzip $filename
done

# Start OpenERP Server
/etc/init.d/odoo-server start

exit 0
