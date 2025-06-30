#!/bin/bash

# Set your log file path
LOGFILE="/var/log/docker-update.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "===== Docker update started at $DATE =====" >> $LOGFILE

# Change to the directory containing docker-compose.yml
cd /mnt/docker || {
  echo "ERROR: /mnt/docker not found" >> $LOGFILE
  exit 1
}

# Pull latest images
echo "Pulling latest images..." | tee -a $LOGFILE
docker-compose pull >> $LOGFILE 2>&1

# Recreate containers with new images
echo "Recreating containers..." | tee -a $LOGFILE
docker-compose up -d >> $LOGFILE 2>&1

# Remove old images no longer used
echo "Cleaning up unused Docker images..." | tee -a $LOGFILE
docker image prune -af >> $LOGFILE 2>&1

echo "===== Docker update completed at $(date '+%Y-%m-%d %H:%M:%S') =====" >> $LOGFILE
echo "" >> $LOGFILE
