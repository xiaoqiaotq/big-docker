####补充修改
1. 增加了misc 文件夹存放hbase，hadoop,hive软件包，docker wget下载太慢
2. 增加了Hbase 配置，regionServers 写死了三台hadoop-slave1,hadoop-slave2,hadoop-slave3
3. hadoop slaves 也写死了
4. jdk 升到8 


####打包镜像
`
git clone https://github.com/xiaoqiaotq/hadoop-cluster-docker
cd hadoop-cluster-docker
cp aa.tar.gz misc 
docker build -t xiaoqiaotq/hadoop:1.0 .
docker network create --driver=bridge hadoop
./start-container.sh 4
`

#### swarm运行
`
docker  -f docker-compose.yml  stack deploy hadoop
`