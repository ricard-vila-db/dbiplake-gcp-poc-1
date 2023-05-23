FROM google/cloud-sdk:alpine as gcloud
WORKDIR /app
ARG KEY_FILE_CONTENT
RUN echo $KEY_FILE_CONTENT | gcloud auth activate-service-account --key-file=-
RUN gsutil cp gs://ccdb34c111111b80-source-bucket/data.txt gs://ccdb34c111111b80-destination-bucket/