# Restore Backup
db_password=XXX
site_name=edibles.ideendevelopers.xyz
db_backup=XXX
#public_file_backup=XXX
#private_file_backup=XXX

cd ../
sudo docker cp server_scripts/backup/$db_backup $(sudo docker compose ps -q backend):/tmp
#sudo docker cp server_scripts/backup/$private_file_backup $(sudo docker compose ps -q backend):/tmp
#sudo docker cp server_scripts/backup/$public_file_backup $(sudo docker compose ps -q backend):/tmp
sudo docker compose exec backend bench --site $site_name restore /tmp/$db_backup --mariadb-root-password $db_password
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend
