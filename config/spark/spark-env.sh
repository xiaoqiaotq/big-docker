# spark on yarn
HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
# history option
SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=hdfs://hadoop-master:9000/shared/spark-logs/"