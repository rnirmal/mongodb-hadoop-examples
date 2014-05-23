#!/bin/bash
# Sets up the required mongo-hadoop connector jars
wget -P /usr/lib/hadoop/lib http://6ad82e5f32a41fccb9dd-2834903aadc19353cae1c339ccf0854e.r14.cf2.rackcdn.com/mongo-hadoop-core-1.2.1-hadoop_2.4.jar
wget -P /usr/lib/hadoop/lib http://6ad82e5f32a41fccb9dd-2834903aadc19353cae1c339ccf0854e.r14.cf2.rackcdn.com/mongo-hadoop-hive-1.2.1-hadoop_2.4.jar
wget -P /usr/lib/hadoop/lib http://6ad82e5f32a41fccb9dd-2834903aadc19353cae1c339ccf0854e.r14.cf2.rackcdn.com/mongo-hadoop-pig-1.2.1-hadoop_2.4.jar
wget -P /usr/lib/hadoop/lib http://6ad82e5f32a41fccb9dd-2834903aadc19353cae1c339ccf0854e.r14.cf2.rackcdn.com/mongo-hadoop-streaming-1.2.1-hadoop_2.4.jar
wget -P /usr/lib/hadoop/lib http://6ad82e5f32a41fccb9dd-2834903aadc19353cae1c339ccf0854e.r14.cf2.rackcdn.com/mongo-java-driver-2.12.1.jar
