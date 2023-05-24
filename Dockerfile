FROM google/cloud-sdk:alpine as gcloud
WORKDIR /app
ARG GCP_CREDENTIALS
ARG SA_ACCOUNT
#RUN export GOOGLE_APPLICATION_CREDENTIALS="[PATH]"
RUN gcloud auth activate-service-account $SA_ACCOUNT --key-file=$GCP_CREDENTIALS && gsutil cp gs://015ba1db99263839-source-bucket/data.txt gs://015ba1db99263839-destination-bucket/