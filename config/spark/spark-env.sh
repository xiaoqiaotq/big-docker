# spark on yarn
HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
# history option
SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=hdfs://hadoop-master:9000/shared/spark-logs/"
SPARK_WORKER_OPTS="-Dspark.worker.cleanup.enabled=true -Dspark.worker.cleanup.interval=1800 -Dspark.worker.cleanup.appDataTtl=3600"