#!/bin/bash

start-master.sh -h 0.0.0.0
start-slave.sh  spark://hadoop-master:7077

