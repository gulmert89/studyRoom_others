# 1. Beginner's Crash Course to Elastic Stack
* The course repo: [Beginner's Crash Course to Elastic Stack Series](https://github.com/LisaHJung/Beginners-Crash-Course-to-Elastic-Stack-Series-Table-of-Contents)
* The YouTube playlist: [Beginner's Crash Course to Elastic Stack](https://www.youtube.com/playlist?list=PL_mJOmq4zsHZYAyK606y7wjQtC0aoE6Es)
## 1.1. Intro to Elasticsearch and Kibana
### 1.1.1. Welcome
* **Kibana:** Provide some kind of a GUI to analyze & visualize things.
* **Nodes:** In a cluster, there could be one or more nodes with unique IDs and names. Each node stores data in JSON format with unique IDs.
    * [From a question] Nodes use cache to find data faster on OS.
* **Index:** Documents could be grouped into an index like "product index" and "customer index" like databases.
* **Shards:** Parts of the data stored in each nodes. For example, "product index" could be divided into 3 shards in 3 different nodes in 1 cluster with each containing 200k documents (600k in total).
    * Sharding boosts performance: I can search through 600k documents in 1 shard in a nodes to retrieve some information and it could take 10 seconds. If we divide the index into 10 shards, we can do the searching in parallel (i.e. simultaneously in each shard which has 60k docs) and retrieve the information in 1 second.
    * Replica Shards: Primary shards are denoted as P0, P1... in the video. Replicas are R0, R1 etc. They are the backups of the primary shards. If one shard dies, replica one quickly replaces it in no time. Also, it speeds up the query searching as well like mentioned.
* Command syntax: `GET _API/parameter`
* **RDBMS vs. Elasticsearch:** Actually, elasticsearch is not a database. It just stores documents to be searched and performed analytics. It is schema-free and designed for full-text searches. You can fine-tune the relevance of your search result when it comes to precision, ranking and recall.
### 1.1.2. Performing CRUD operations
```js
GET _cluster/health
GET _nodes/stats

// creates an index
PUT favorite_candy

// indexes a document
POST favorite_candy/_doc
{
  "first_name": "Mert",
  "candy": "Sour Skittles"
}

// this assigns a random ID
POST favorite_candy/_doc
{
  "first_name": "Mert",
  "candy": "Sour Skittles"
}

// this assigns a random ID
POST favorite_candy/_doc  
{
  "first_name": "Mert",
  "candy": "Sour Skittles"
}

// this assigns our desired ID, which is 1
POST favorite_candy/_doc/1
{
  "first_name": "Mert",
  "candy": "Sour Skittles"
}

// overwrites Mert's doc
PUT favorite_candy/_doc/1
{
  "first_name": "Betül"
}

// so we use '_create' endpoint to prevent overwriting
PUT favorite_candy/_create/1
{
  "first_name": "Mert",
  "candy": "Sour Skittles"  // throws error since we already have the doc with ID of 1
}

// read the doc
GET favorite_candy/_doc/1

// updates the document
POST favorite_candy/_update/1
{
  "doc": {
    "candy": "M&M's",
    "last_name": "Gül"
  }
}

// delete a document
DELETE favorite_candy/_doc/MkOTNYwBI2hu9uu_O0Ez

# THIS WAS THE DEFAULT QUERY.
// Click the Variables button, above, to create your own variables.
GET ${exampleVariable1} // _search
{
  "query": {
    "${exampleVariable2}": {} // match_all
  }
}
```
