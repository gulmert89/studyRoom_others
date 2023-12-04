# 1. Beginner's Crash Course to Elastic Stack - Part 1: Intro to Elasticsearch and Kibana
* **Kibana:** Provide some kind of a GUI to visualize things.
* **Nodes:** In a cluster, there could be one or more nodes with unique IDs and names. Each node stores data in JSON format with unique IDs.
* **Index:** Documents could be grouped into an index like "product index" and "customer index" like databases.
* **Shards:** Parts of the data stored in each nodes. For example, "product index" could be divided into 3 shards in 3 different nodes in 1 cluster with each containing 200k documents (600k in total).
  * Sharding boosts performance: I can search through 600k documents in 1 shard in a nodes to retrieve some information and it could take 10 seconds. If we divide the index into 10 shards, we can do the searching in parallel (i.e. simultaneously in each shard which has 60k docs) and retrieve the information in 1 second.
  * Replica Shards: Original shards are denoted as P0, P1... in the video. Replicas are R0, R1 etc. They are the backups of the main shards. If one shard dies, replica one quickly replaces it without losing time. Also, it speeds up the query searching as well like mentioned.
  
