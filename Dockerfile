FROM google/cloud-sdk:alpine as gcloud
WORKDIR /app
#ARG GCP_CREDENTIALS
ARG SA_ACCOUNT
RUN export GOOGLE_APPLICATION_CREDENTIALS="../dbiplake-gft-poc-387706-2d52428afe3c.json"
RUN echo $GOOGLE_APPLICATION_CREDENTIALS
RUN gcloud auth activate-service-account $SA_ACCOUNT --key-file=$GOOGLE_APPLICATION_CREDENTIALS
RUN gsutil cp gs://015ba1db99263839-source-bucket/data.txt gs://015ba1db99263839-destination-bucket/
#RUN gcloud auth activate-service-account $SA_ACCOUNT --key-file=$GCP_CREDENTIALS && gsutil cp gs://015ba1db99263839-source-bucket/data.txt gs://015ba1db99263839-destination-bucket/
#RUN echo $GCP_CREDENTIALS | gcloud auth activate-service-account 485283744631-compute@developer.gserviceaccount.com --key-file=- && gsutil cp gs://015ba1db99263839-source-bucket/data.txt gs://015ba1db99263839-destination-bucket/