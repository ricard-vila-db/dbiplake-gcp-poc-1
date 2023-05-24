FROM google/cloud-sdk:alpine as gcloud
WORKDIR /app
ARG GCP_CREDENTIALS
#RUN export GOOGLE_APPLICATION_CREDENTIALS="[PATH]"
RUN echo $GCP_CREDENTIALS | gcloud auth activate-service-account --key-file=- && gsutil cp gs://015ba1db99263839-source-bucket/data.txt gs://015ba1db99263839-destination-bucket/