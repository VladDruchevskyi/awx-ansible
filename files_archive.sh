#! /bin/bash

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/weekly_files/$HOSTNAME/$TIMESTAMP"
find /backup/CS/daily/$HOSTNAME/ -maxdepth 1 -type d -mtime +21 -exec rm -f {} \;

  mkdir -p "$BACKUP_DIR"
  mkdir -p "/backup/CS/weekly_files/$HOSTNAME"

for d in /home/* ; do tar -czvf "$d.tar.gz" "$d" ;
done
cp -r /home/*.tar.gz $BACKUP_DIR
cp -r $BACKUP_DIR /backup/CS/weekly_files/$HOSTNAME
rm -r /backup/weekly_files/$HOSTNAME
rm /home/*.tar.gz
