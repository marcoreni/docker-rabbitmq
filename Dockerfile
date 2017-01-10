FROM rabbitmq:management

ENV RABBITMQ_ERLANG_COOKIE= \
  RABBITMQ_DEFAULT_USER=guest \
  RABBITMQ_DEFAULT_PASS=guest \
  RABBITMQ_DEFAULT_VHOST=/ \
  RABBITMQ_NODE_PORT=5672 \
  RABBITMQ_DIST_PORT=25672 \
  RABBITMQ_NET_TICKTIME=60 \
  RABBITMQ_CLUSTER_PARTITION_HANDLING=ignore \
  ERL_EPMD_PORT=4369 \
  RABBITMQ_MANAGEMENT_PORT=15672 \
  MARATHON_URI=http://marathon.mesos:8080

RUN apt-get update && apt-get install -y python python-pip

RUN chown -R rabbitmq:rabbitmq /var/lib/rabbitmq
ADD ./rabbitmq-cluster.py /rabbitmq-cluster.py
RUN chmod +x /rabbitmq-cluster.py

ENTRYPOINT ["/rabbitmq-cluster.py"]
