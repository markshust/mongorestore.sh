#!/bin/bash
## This script syncs a MongDB backup from a Google Cloud Storage bucket and
## mongorestore's it to a local db.
##
## Author: Mark Shust <mark@shust.com>
## Version: 1.0.0

BUCKET=my-bucket-name
FOLDER=folder-name/$1
BACKUP_DIR=./.backups/
DB_NAME=localdb
DB_HOST=localhost
DB_PORT=27017

if [ -z $1 ]; then
  echo 'Please specify a subdirectory to sync from...'
  exit 0
fi

mkdir -p $BACKUP_DIR

gsutil -m cp -r gs://$BUCKET/$FOLDER $BACKUP_DIR

mongorestore --db $DB_NAME -h $DB_HOST --port $DB_PORT --drop $BACKUP_DIR/$1/

echo 'Database restore complete.'