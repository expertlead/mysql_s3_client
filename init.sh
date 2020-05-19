#!/bin/bash

set -e

filename_prefix="dump-$(date +'%m-%d-%Y_%H-%M').sql" #will output: dump-11-20-2019_16-38.sql

parseEnv() {
  ALLOW_SSL=${DB_ALLOW_SSL:-allow}
  # DB properties
  HOST=${DB_DUMP_HOST:-localhost}
  PORT=${DB_DUMP_PORT:-3360}
  USER=${DB_DUMP_USER:-mysql}
  PASS=${DB_DUMP_PASS:-mysql}
  NAME=${DB_DUMP_NAME:-mysql}
  # dump file properties
  FILE_NAME=${DB_DUMP_FILE_NAME:-$filename_prefix}
  DUMP_PATH=/dumps/${FILE_NAME}
  # s3 properties, bucket and endpoint
  BUCKET=${AWS_BUCKET_NAME:-dumps}
  ENDPOINT=${AWS_END_POINT:-https://s3.amazonaws.com}
  # construct /YEAR/MONTH/DAY/HOUR path
  FOLDER_NAME=$(date +%F | tr '-' '//')/$(date +%H)
  FILE_PATH=${FOLDER_NAME}/${FILE_NAME}
}

dumpDB() {
 MYSQL_PWD=${PASS} mysqldump \
    --single-transaction \
    --quick \
    --lock-tables=false \
    -h ${HOST} \
    -u ${USER} \
    -P ${PORT} \
    ${NAME} > ${DUMP_PATH}
}

moveDump() {
  aws s3 mv ${DUMP_PATH} s3://${BUCKET}/${FILE_PATH} --endpoint=${ENDPOINT}
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  parseEnv || exit 1
  dumpDB || exit 1
  moveDump || exit 1
fi
