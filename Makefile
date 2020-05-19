build-docker:
	docker build -f Dockerfile . -t expertlead/mysql_s3_client:${DOCKER_TAG}

push-image:
	docker push expertlead/mysql_s3_client:${DOCKER_TAG}
