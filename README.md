# sfis_sync
This is a data synchronization tool for the factory. Each workstation will store operation results locally, as well as periodically sync those results to an S3 bucket. `sfis_sync_setup.sh` will only work in a linux environment that has `cron.hourly` built in.

## Running `sfis_sync_setup.sh`
```
$ sudo ./sfis_sync_setup.sh <aws_access_key> <aws_secret> </abs/path/to/local/sync/directory> s3://<bucket_name>
