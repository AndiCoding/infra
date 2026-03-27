#!/bin/bash

DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="/home/andreas/backups/linkwarden"
POSTGRES_POD=$(kubectl get pod -n default -l app=postgres -o)
jsonpath='{.items[0].metadata.name}'

mkdir -p "$BACKUP_DIR"

echo "Backing up database ..."
kubectl exec -it "$POSTGRES_POD" -n default -- pg_dump -U linkwarden linkwarden > "$BACKUP_DIR/db-$DATE.sql"

echo "Backing up files ..."
sudo tar -czf "$BACKUP_DIR/files-$DATE.tar.gz" /data/linkwarden

echo "Done! Backups saved to $BACKUP_DIR"
