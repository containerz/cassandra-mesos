#!/bin/sh

jar='cassandra-mesos*.jar'

check_jar() {
    jars=$(find . -maxdepth 1 -name "$jar" | wc -l)

    if [ $jars -eq 0 ]
    then
        echo "$jar not found"
        exit 1
    elif [ $jars -gt 1 ]
    then
        echo "More than one $jar found"
        exit 1
    fi
}

export HOST=master
export PORT0=18080

export MESOS_ZK=zk://master:2181/mesos
export MESOS_USER=

export CASSANDRA_ZK=zk://master:2181/cassandra-mesos
export CASSANDRA_NODE_COUNT=2
export CASSANDRA_RESOURCE_DISK_MB=1024

export CASSANDRA_RESOURCE_MEM_MB=256
export CASSANDRA_CLUSTER_NAME=dev-cluster
export CASSANDRA_RESOURCE_CPU_CORES=0.5

export EXECUTOR_FILE_PATH=cassandra-mesos-0.1.1.jar
export CASSANDRA_FILE_PATH=apache-cassandra-2.1.4-bin.tar.gz
export JRE_FILE_PATH=jre.tar.gz

check_jar
java -jar $jar "$@"

