FROM ubuntu:16.04

MAINTAINER KiwenLau <kiwenlau@gmail.com>

WORKDIR /root
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget

# install hadoop 2.7.2
# RUN wget https://github.com/kiwenlau/compile-hadoop/releases/download/2.7.2/hadoop-2.7.2.tar.gz && \
COPY misc/hadoop-2.7.7.tar.gz .
COPY misc/hbase-2.2.0-bin.tar.gz .
COPY misc/apache-hive-2.3.5-bin.tar.gz .

RUN  tar -xzvf hadoop-2.7.7.tar.gz && \
    mv hadoop-2.7.7 /usr/local/hadoop && \
    rm hadoop-2.7.7.tar.gz

RUN  tar -xzvf hbase-2.2.0-bin.tar.gz && \
    mv hbase-2.2.0 /usr/local/hbase && \
    rm hbase-2.2.0-bin.tar.gz

RUN  tar -xzvf apache-hive-2.3.5-bin.tar.gz && \
    mv apache-hive-2.3.5-bin /usr/local/hive && \
    rm apache-hive-2.3.5-bin.tar.gz

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV HBASE_HOME=/usr/local/hbase
ENV HIVE_HOME=/usr/local/hive
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin:$HBASE_HOME/bin:$HIVE_HOME/bin


# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/ /tmp/

EXPOSE 50070 8088 19888 10002 16010 16030

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh && \
    mv /tmp/hbase/* $HBASE_HOME/conf

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]

