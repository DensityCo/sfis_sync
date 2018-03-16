#!/usr/bin/env bash

apt-get install -y python-setuptools

easy_install awscli

SFIS_SYNC_PATH="/etc/cron.hourly/sfis_sync.sh"

touch $SFIS_SYNC_PATH
chmod +x $SFIS_SYNC_PATH
echo "#!/usr/bin/env bash" >> $SFIS_SYNC_PATH
echo "export AWS_ACCESS_KEY_ID=$1" >> $SFIS_SYNC_PATH
echo "export AWS_SECRET_ACCESS_KEY=$2" >> $SFIS_SYNC_PATH
echo "aws s3 sync $3 $4" >> $SFIS_SYNC_PATH
