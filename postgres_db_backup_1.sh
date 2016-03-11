#!/bin/bash

DIR=/var/pgdump
DB=Grafen-Tee-LIVE

rm $DIR/$DB*.tar
sudo -u odoo pg_dump --format t --file "$DIR/$DB $(date --rfc-3339 seconds).sql.gz" $DB
