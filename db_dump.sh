#! /bin/bash

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/daily_db/$HOSTNAME/$TIMESTAMP"
MYSQL_USER="root"
MYSQL_PASSWORD=""
find /backup/CS/daily/$HOSTNAME/ -maxdepth 1 -type d -mtime +3 -exec rm -f {} \;

  mkdir -p "$BACKUP_DIR"
  mkdir -p "/backup/CS/daily/$HOSTNAME"

databases=`mysql --user=$MYSQL_USER -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
  mysqldump --force --opt --user=$MYSQL_USER --databases $db | gzip > "$BACKUP_DIR/$db.gz"
  cp -r $BACKUP_DIR /backup/CS/daily/$HOSTNAME
done
rm -r /backup/daily_db/$HOSTNAME
