#!/bin/bash
hdfs namenode -formatjps

hadoop-daemon.sh stop namenode
hadoop-daemon.sh stop datanode
yarn-daemon.sh stop resourcemanager
yarn-daemon.sh stop nodemanager

