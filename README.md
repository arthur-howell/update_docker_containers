Docker Weekly Auto-Updater
==========================

Description:
------------
This script automatically updates all Docker containers defined in a single docker-compose.yml file located at:

    /mnt/docker/docker-compose.yml

It performs the following steps:
1. Pulls the latest images for all services.
2. Recreates the containers using the updated images.
3. Removes any old, unused images.
4. Logs all actions and results to: /var/log/docker-update.log

Setup Instructions:
-------------------

1. Place the script at:
       /usr/local/bin/update-docker-containers.sh

2. Make it executable:
       chmod +x /usr/local/bin/update-docker-containers.sh

3. Create the log directory (if it doesn’t exist):
       sudo mkdir -p /var/log

4. Test the script manually:
       sudo /usr/local/bin/update-docker-containers.sh

   You should see output like:
       Pulling latest images...
       Recreating containers...
       Cleaning up unused Docker images...
       Docker update completed at YYYY-MM-DD HH:MM:SS

5. Add it to your crontab to run weekly:

       crontab -e

   Add this line to run every Sunday at 3:30 AM:

       30 3 * * 0 /usr/local/bin/update-docker-containers.sh

6. To monitor output:
       tail -f /var/log/docker-update.log

Notes:
------

- This script assumes all of your containers are defined in a single compose file at /mnt/docker/docker-compose.yml.
- It uses docker-compose. If you are using Docker Compose as a plugin (`docker compose`), modify the script accordingly.
- No downtime occurs unless images are actually updated. Containers will only restart if a new image is pulled.
- No action is taken if the containers are already using the latest image.

Maintenance:
------------

- You can safely review the log at any time:
      less /var/log/docker-update.log

- To rotate the log (optional), consider using logrotate or just clear it periodically:
      sudo truncate -s 0 /var/log/docker-update.log

License:
--------

No license restrictions. Use, modify, or share it however you want.# update_docker_containers
