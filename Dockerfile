# Use a small Alpine Linux base image
FROM alpine:latest

WORKDIR /app

# Update the package lists and install required packages
RUN apk update && \
    apk add --no-cache vim aws-cli nodejs npm

WORKDIR /app

RUN npm install -g npm@latest
RUN npm install -g serverless
RUN npm install --save-dev serverless-localstack@latest
RUN npm install --save-dev serverless-deployment-bucket@latest && \

    aws configure set aws_access_key_id dummy_access_key && \
    aws configure set aws_secret_access_key dummy_secret_key && \
    aws configure set default.region us-east-1 && \
    aws configure set default.output json

# Set the default command to run when the container starts
CMD ["/usr/local/bin/start_localstack"]