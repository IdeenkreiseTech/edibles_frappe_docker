# Create Site and Install Application
db_password=XXX
admin_password=XXX
encryption_key=XXX
git_password=XXX
site_name=edibles.ideendevelopers.xyz
TAG=1.0.0

cd ../
sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password
sudo docker pull ghcr.io/ideenkreisetech/edibles_app/edibles_app:$TAG
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml up -d
sudo docker compose exec backend bench new-site $site_name  --no-mariadb-socket --mariadb-root-password $db_password --admin-password $admin_password
sudo docker compose exec backend bench --site $site_name install-app edibles_app
sudo docker compose exec backend bench --site $site_name set-config encryption_key $encryption_key
sudo docker compose exec backend bench --site $site_name enable-scheduler
