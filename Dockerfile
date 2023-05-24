FROM google/cloud-sdk:alpine as gcloud
WORKDIR /app
ARG GCP_CREDENTIALS
RUN echo $GCP_CREDENTIALS | gcloud auth activate-service-account --key-file=- && gsutil cp gs://ccdb34c111111b80-source-bucket/data.txt gs://ccdb34c111111b80-destination-bucket/