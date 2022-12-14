#!/usr/bin/bash

echo "Backing up this script"
rclone copy /home/pi/docker/backup_script.sh dropbox:/rpi/backup/ -P
echo "Done"

echo "Backing up Bookstack"
echo "dumping sql"
docker exec -t bookstack_db /bin/bash -c 'mysqldump -u bookstack -pH3110_W0r1d bookstack > /config/backup/backup.sql'
echo "uploading sql to cloud"
rclone copy /home/pi/docker/configs/bookstack_db/backup dropbox:/rpi/backup/bookstack_db -P
echo "uploading app folder to cloud"
rclone copy /home/pi/docker/configs/bookstack/www dropbox:/rpi/backup/bookstack/www -P
echo "Done"

echo "Backing up snippet box"
echo "uploading sql"
rclone copy /home/pi/docker/configs/snippet-box/db.sqlite3 dropbox:/rpi/backup/snippet-box -P
echo "Done"

echo "Backing up dashy config"
rclone copy /home/pi/docker/configs/dashy/config.yml dropbox:/rpi/backup/dashy/ -P
echo "Done"

echo "Backing up uptime kuma db"
rclone copy /home/pi/docker/configs/uptime-kuma dropbox:/rpi/backup/uptime-kuma -P
echo "Done"

echo "Backing up mealie"
rclone copy /home/pi/docker/configs/mealie dropbox:/rpi/backup/mealie -P
echo "Done"
