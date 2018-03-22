#!/usr/bin/env bash

apt-get install -y python-setuptools

easy_install awscli

SFIS_SYNC_PATH="/etc/cron.hourly/sfis_sync"

touch $SFIS_SYNC_PATH
chmod +x $SFIS_SYNC_PATH
echo "#!/usr/bin/env bash" > $SFIS_SYNC_PATH
echo "export AWS_ACCESS_KEY_ID=$1" >> $SFIS_SYNC_PATH
echo "export AWS_SECRET_ACCESS_KEY=$2" >> $SFIS_SYNC_PATH
OPERATION=$(basename $3)
LOCAL_PATH=$3$OPERATION
S3_PATH=$4/$OPERATION
LOG_PATH="$LOCAL_PATH/sync_logs.txt"
echo "OPERATION=$OPERATION" >> $SFIS_SYNC_PATH
echo "LOCAL_PATH=$LOCAL_PATH" >> $SFIS_SYNC_PATH
echo "S3_PATH=$S3_PATH" >> $SFIS_SYNC_PATH
echo "function timestamp() {" >> $SFIS_SYNC_PATH
echo " date \"+%Y-%m-%d %H:%M:%S\"" >> $SFIS_SYNC_PATH
echo "}" >> $SFIS_SYNC_PATH
echo "TIMESTAMP=\$(timestamp)" >> $SFIS_SYNC_PATH
echo "exists=\$(aws s3 ls $S3_PATH/sync_logs.txt)" >> $SFIS_SYNC_PATH
echo "if [ -z \"\$exists\" ]; then" >> $SFIS_SYNC_PATH
echo "  mkdir $LOCAL_PATH" >> $SFIS_SYNC_PATH
echo "  touch $LOG_PATH" >> $SFIS_SYNC_PATH
echo "else" >> $SFIS_SYNC_PATH
echo "  aws s3 cp $S3_PATH/sync_logs.txt $LOG_PATH" >> $SFIS_SYNC_PATH
echo "fi" >> $SFIS_SYNC_PATH
echo "echo \"Last sync: \$TIMESTAMP\" >> $LOG_PATH" >> $SFIS_SYNC_PATH
echo "aws s3 sync $3 $4" >> $SFIS_SYNC_PATH
