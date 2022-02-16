#!/usr/bin/env bash
# shellcheck disable=SC2034

export S3_ACCESS_KEY="REDACTED"
export S3_SECRET_KEY="REDACTED"
PBX_BACKUP_PATH="/var/lib/3cxpbx/Instance1/Data/Backups"
S3_PATH="s3://${MY_S3_BUCKET_NAME}/"

set -ex

for f in "${PBX_BACKUP_PATH}"/*.zip; do
  s4cmd sync "${f}" "${S3_PATH}"
done

unset S3_ACCESS_KEY
unset S3_SECRET_KEY
