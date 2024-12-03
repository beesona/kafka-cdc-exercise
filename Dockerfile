FROM node:22-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package.json ./
USER node
RUN npm install
COPY --chown=node:node ./dist .
ARG CONSUMER_NAME="default-consumer"
ARG KAFKA_URL="http://localhost:9092"
ARG KAFKA_GROUP_ID="default-group-id"
ARG ELASTIC_URL="http://localhost:9200"
ARG ELASTIC_API_KEY="MY_API_KEY"
ARG TOPIC_NAME="default-topic"
ARG INDEX_NAME="default-index"
ENV CONSUMER_NAME=${CONSUMER_NAME}
ENV NODE_ENV=development
ENV KAFKA_URL=${KAFKA_URL}
ENV KAFKA_GROUP_ID=${KAFKA_GROUP_ID}
ENV ELASTIC_URL=${ELASTIC_URL}
ENV ELASTIC_API_KEY=${ELASTIC_API_KEY}
ENV TOPIC_NAME=${TOPIC_NAME}
ENV INDEX_NAME=${INDEX_NAME}
CMD node $CONSUMER_NAME