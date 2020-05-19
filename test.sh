#!/bin/bash

export DB_DUMP_HOST=10.10.0.1
export DB_DUMP_PORT=5444
export DB_DUMP_USER=root
export DB_DUMP_PASS=123som34andomP4ss
export DB_DUMP_NAME=dumper
export DB_DUMP_FILE_NAME=some_dump
export AWS_BUCKET_NAME=backups
export AWS_END_POINT=http://some.url.dom

source ./init.sh

parseEnv
if [ ${HOST} != "10.10.0.1" ]; then
  echo "Invalid host name" && exit 1
fi

if [ ${PORT} != "5444" ]; then
  echo "Invalid port" && exit 1
fi

if [ ${USER} != "root" ]; then
  echo "Invalid user" && exit 1
fi

if [ ${PASS} != "123som34andomP4ss" ]; then
  echo "Invalid password" && exit 1
fi

if [ ${NAME} != "dumper" ]; then
  echo "Invalid DB name" && exit 1
fi

if [ ${FILE_NAME} != "some_dump" ]; then
  echo "Invalid file name" && exit 1
fi

if [ ${DUMP_PATH} != "/dumps/some_dump" ]; then
  echo "Invalid local file path" && exit 1
fi

if [ ${BUCKET} != "backups" ]; then
  echo "Invalid bucket name" && exit 1
fi

if [ ${ENDPOINT} != "http://some.url.dom" ]; then
  echo "Invalid AWS endpoint" && exit 1
fi

echo "End of tests! (SUCCESS)"
