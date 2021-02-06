FROM docker.elastic.co/elasticsearch/elasticsearch:7.7.0

#this is to tell that we are passing these arguments at runtime
ARG ENV_VAR_AWS_ACCESS_KEY_ID
ARG ENV_VAR_AWS_SECRET_ACCESS_KEY

ENV AWS_ACCESS_KEY_ID ${ENV_VAR_AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY ${ENV_VAR_AWS_SECRET_ACCESS_KEY}
ENV xpack.security.enabled 'false'
ENV  xpack.monitoring.enabled 'false'
ENV xpack.graph.enabled 'false'
ENV xpack.watcher.enabled 'false'
ENV discovery.type 'single-node'
ENV bootstrap.memory_lock 'true'
ENV indices.memory.index_buffer_size '30%'

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3
RUN /usr/share/elasticsearch/bin/elasticsearch-keystore create
RUN echo $AWS_ACCESS_KEY_ID | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.access_key
RUN echo $AWS_SECRET_ACCESS_KEY | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.secret_key