# Kafka-Tools

## disk_use_by_topic_broker.sh:

A small tool to print a break down of disk usage per topic per broker.
For AWS MSk cluster, run the tool on a client machine.

Example:

AWS MSK cluster with TLS enabled:

```
$ ./disk_use_by_topic_broker.sh "/home/ec2-user/kafka_2.12-2.2.1/bin" 1,2 b-1.test-msk.xxx.c12.kafka.us-east-1.amazonaws.com:9094,b-2.test-msk.xxx.c12.kafka.us-east-1.amazonaws.com:9094 tls /home/ec2-user/client.properties

==Broker 1 disk usage per topic==
               Topic	Size (in bytes)
  __consumer_offsets	938
          luna_topic	0
        my-msk-topic	0
   performance-topic	0
  testS3ConnectTopic	0
  
==Broker 2 disk usage per topic==
               Topic	Size (in bytes)
  __consumer_offsets	938
          luna_topic	0
        my-msk-topic	0
   performance-topic	0
  testS3ConnectTopic	0
  ```

AWS MSK cluster without TLS:

```
$ ./disk_use_by_topic_broker.sh "/home/ec2-user/kafka_2.12-2.2.1/bin" 2 "b-1.test-msk.xxx.c12.kafka.us-east-1.amazonaws.com:9092,b-2.test-msk.xxx.c12.kafka.us-east-1.amazonaws.com:9092" tls_false

==Broker 2 disk usage per topic==
               Topic	Size (in bytes)
  __consumer_offsets	938
          luna_topic	0
        my-msk-topic	0
   performance-topic	0
  testS3ConnectTopic	0
  ```
