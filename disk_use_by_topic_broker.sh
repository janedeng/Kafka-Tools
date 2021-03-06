#!/bin/sh

if [ $# -lt 4 ]; then
        echo "Usage: $0 <path to Kafka tools bin> <broker list> bootstrap_server_string [tls|tls_false] full_path_to_client_config_property_file.."
        exit 1
fi

path=$1
IFS="," read -a brokers <<< $2
bootstrap_string=$3
tls_enable=$4

if [ $tls_enable == "tls" ]; then
        client_conf=$5
        getKafkaTopic_command="$path/kafka-topics.sh --list --bootstrap-server $bootstrap_string --command-config $client_conf"
	kafkaLogDir_command="$path/kafka-log-dirs.sh --bootstrap-server $bootstrap_string --command-config $client_conf --describe"
elif [ $tls_enable == "tls_false" ]; then
	getKafkaTopic_command="$path/kafka-topics.sh --list --bootstrap-server $bootstrap_string "
        kafkaLogDir_command="$path/kafka-log-dirs.sh --bootstrap-server $bootstrap_string --describe"
fi


for b in "${brokers[@]}"
do
	printf "\n%s\n" "==Broker $b disk usage per topic=="
	printf "%20s\t%s\n" "Topic" "Size (in bytes)"
	for i in $(eval "$getKafkaTopic_command")
	do
		logSize=$(eval "$kafkaLogDir_command --topic-list $i --broker-list $b | grep '^{'   | jq '[ ..|.size? | numbers ] | add'")
		printf "%20s\t%s\n" $i $logSize
	done
done

