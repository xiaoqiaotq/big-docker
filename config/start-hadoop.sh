#!/bin/bash

hadoop-daemon.sh start namenode
yarn-daemon.sh start resourcemanager
hadoop-daemon.sh start datanode
yarn-daemon.sh start nodemanager

