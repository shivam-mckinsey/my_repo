#!/usr/bin/env python

import os
import time
import subprocess

dump_dir = '/var/pgdump'
db_username = 'odoo'
db_password = 'odoo'
db_names = ['demo_blitzzcar']
curr_month = int(time.strftime('%Y%m%d'))

for db_name in db_names:
    try:
        file_path = ''
        dumper = " -U %s -Z 9 -f %s -F c %s  "
        os.putenv('redhat', db_password)
        bkp_file = '%s_%s.sql' % (db_name, time.strftime('%Y%m%d_%H_%M_%S'))
#        glob_list = glob.glob(dump_dir + db_name + '*' + '.pgdump')
        file_path = os.path.join(dump_dir, bkp_file)
        command = 'pg_dump' + dumper % (db_username, file_path, db_name)
        subprocess.call(command, shell=True)
        subprocess.call('gzip ' + file_path, shell=True)
    except:
        print "Couldn't backup database" % (db_name)

os.chdir("/var/pgdump")
for i in os.listdir(os.getcwd()):	
	bkp_month = int (i[-24:-16])	
	if (curr_month == bkp_month + 100 or curr_month >= bkp_month + 8900):
		os.remove(i)


