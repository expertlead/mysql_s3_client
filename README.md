## Introduction
**mysql_s3_client** is a docker image which has both:
- **MySQL**
- **AWS-CLI**

## Strategy
The container will dump the backup under `/dumps` folder, then it will shipped
to s3 by s3-cli client in an encrypted manner, at the end the dump file will be
deleted.

The dump will be located inside an S3 bucket under the following path
`/YEAR/MONTH/DAY/HOUR/dump.sql` after the process is done.

## ENV variables
| ENV Variable          | Value | Description                               |
|-----------------------|-------|-------------------------------------------|
|AWS_BUCKET_NAME        |string | The bucket name                           |
|AWS_ACCESS_KEY_ID      |string | The access key ID                         |
|AWS_SECRET_ACCESS_KEY  |string | The access key secret                     |
|AWS_DEFAULT_REGION     |string | The region where S3 is located            |
|AWS_END_POINT          |string | The endpoint of the s3 backend            |
|DB_DUMP_FILE_NAME      |string | The generated dump file name              |
|DB_DUMP_NAME           |string | The database name                         |
|DB_DUMP_USER           |string | The DB user name                          |
|DB_DUMP_PASS           |string | The DB user password                      |
|DB_DUMP_HOST           |string | The DB DSN connection                     |
|DB_DUMP_PORT           |int    | The DB port                               |

# How to use
```bash
$ docker run \
      -e AWS_BUCKET_NAME=backups \
      -e AWS_ACCESS_KEY_ID=[Access Key] \
      -e AWS_SECRET_ACCESS_KEY=[Secret Key] \
      -e AWS_DEFAULT_REGION=[Region] \
      -e DB_DUMP_FILE_NAME=dump.bak \
      -e DB_DUMP_USER=[DB User] \
      -e DB_DUMP_PASS=[DB Pass] \
      -e DB_DUMP_HOST=[DB Host] \
      -e DB_DUMP_NAME=[DB Name] \
      -e DB_DUMP_PORT=[DB Port] \
      --mount source=db-dump,target=/dumps \
      expertlead/mysql_sq_client 
```
