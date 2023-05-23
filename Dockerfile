FROM google/cloud-sdk:alpine as gcloud
WORKDIR /app

RUN gsutil cp gs://ccdb34c111111b80-source-bucket/data.txt gs://ccdb34c111111b80-destination-bucket/