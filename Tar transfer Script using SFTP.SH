#!/bin/bash

#Purpose: - File Transfer to Remote Server(Windows -FTP)
#Creation Date: - 12th November 2016
#Version:- 1.0

#SourceIP='10.127.127.94'
SourceFolder='/usr/sap/BSD/interface/onebi/P2PG0085A/temp' 
filename='P2P_CCTR.csv'
#please supply filename as 'filename.tar.qz'
tar_filename='P2P_CCTR.csv.tar.gz'  

DestIP='93.183.10.20'
#windows destination folder 
DestFolder='IT\\BSD\\incoming' 

#FTP Details
USER='NagarroSftp'
PASSWD='R3ALdxMD33'

echo "this step is complete "
cd $SourceFolder
tar -czvf $tar_filename $filename



echo "tar is created "
#Using SFTP

sshpass -p $PASSWD sftp -P 5050 $USER@$DestIP <<EOT
   pwd
   cd $DestFolder
   pwd
   put $tar_filename
   bye
EOT
echo "script is complete "
rm $tar_filename
rm $filename

#If target in Windows FTP
#ftp -n -v $DestIP << EOT
#ascii
#user $USER $PASSWD
#prompt
#cd $DestFolder
#put $tar_filename
#bye
#EOT

#If Target in Linux FTP 
#ftp -n $HOST <<END_SCRIPT
#quote USER $USER
#quote PASS $PASSWD
#put $FILE
#quit
#END_SCRIPT

exit 0
