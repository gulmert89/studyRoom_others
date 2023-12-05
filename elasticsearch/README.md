# 1. Beginner's Crash Course to Elastic Stack
* The course repo: [Beginner's Crash Course to Elastic Stack Series](https://github.com/LisaHJung/Beginners-Crash-Course-to-Elastic-Stack-Series-Table-of-Contents)
* The YouTube playlist: [Beginner's Crash Course to Elastic Stack](https://www.youtube.com/playlist?list=PL_mJOmq4zsHZYAyK606y7wjQtC0aoE6Es)
## 1.1. Intro to Elasticsearch and Kibana
### 1.1.1. Theory
* **Kibana:** Provide some kind of a GUI to analyze & visualize things.
* **Nodes:** In a cluster, there could be one or more nodes with unique IDs and names. Each node stores data in JSON format with unique IDs.
    * [From a question] Nodes use cache to find data faster on OS.
* **Index:** Documents could be grouped into an index like "product index" and "customer index" like databases.
* **Shards:** Parts of the data stored in each nodes. For example, "product index" could be divided into 3 shards in 3 different nodes in 1 cluster with each containing 200k documents (600k in total).
    * Sharding boosts performance: I can search through 600k documents in 1 shard in a nodes to retrieve some information and it could take 10 seconds. If we divide the index into 10 shards, we can do the searching in parallel (i.e. simultaneously in each shard which has 60k docs) and retrieve the information in 1 second.
    * Replica Shards: Primary shards are denoted as P0, P1... in the video. Replicas are R0, R1 etc. They are the backups of the primary shards. If one shard dies, replica one quickly replaces it in no time. Also, it speeds up the query searching as well like mentioned.
* Command syntax: `GET _API/parameter`
* **RDBMS vs. Elasticsearch:** Actually, elasticsearch is not a database. It just stores documents to be searched and performed analytics. It is schema-free and designed for full-text searches. You can fine-tune the relevance of your search result when it comes to precision, ranking and recall.
### 1.1.2. Practice: Performing CRUD operations
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

# THIS WAS THE DEFAULT QUERY when I installed elasticsearch.
// Click the Variables button, above, to create your own variables.
GET ${exampleVariable1} // _search
{
    "query": {
        "${exampleVariable2}": {} // match_all
    }
}
```
## 1.2. Relevance of a Search
### 1.2.1. Theory
* Documents with similar traits are grouped into an index.
* Precision & recall don't determine which of the returned documents are more relevant compared to each other. This is determined by ***ranking***.
* **Hit**: A search result presented to user.
* There are multiple factors to compute a document's ranking score. We will use these 2 for now:
    * **Term Frequency (TF):** Calculates the number of query terms mentioned in the document. Let the query be "how to form good habits". It calculates the frequency of each word (i.e. "how", "to", "form", "good", "habits") in the documents. For example, if "habits" is mentioned 4 times in a doc while others have 3, 2 or 1 time, TF of the best ranked hit/doc will be $TF=4.$ Of course it has a slightly different normalized equation of this metric and the score is not 4 blatantly.
    * **Inverse Document Frequency (IDF):** It diminishes the weight of terms that occur very frequently in the document set and increases the weight of terms that occur rarely.
* In other words,

    $TF(word)=\frac{\text{Total number of words in the document}}
    {\text{Number of times the word appears in a document}}$
    
    $IDF(word)=log_e(\frac{\text{Total number of documents}}{\text{Number of documents with the word in it}})$

    $TF\text{-}IDF(word)=TF(word)×IDF(word)$
### 1.2.2. Practice: Search for information
* By the way, we can delete an index we uploaded just by typing `DELETE news_headlines`.
* Result of `GET news_headlines/_search`:
    ```js
    ...
    },
    "hits": {
        "total": {
        "value": 10000,
        "relation": "gte"
        },
    ...
    ```
    * First 10k results are retrieved. The `relation` field tells you this:
        * `gte`: Equal or greater than 10k.
        * `eq`: Equal to that number.
* Result of
    ```js
    // get the total number of hits
    GET news_headlines/_search
    {
    "track_total_hits": true
    }
    ```
    is this:
    ```js
    ...
    },
      "hits": {
        "total": {
            "value": 209527,
            "relation": "eq"
        },
    ...
    ```
* There are two ways to retrieve data in elasticsearch: Aggregations and Queries.
    * ***Queries*** tell elasticsearch to retrieve results that match the criteria.
        ```js
        // syntax
        GET enter_name_of_the_index_here/_search
        {
            "query": {
                "Specify the type of query here": {
                    "Enter name of the field here": {
                        "gte": "Enter lowest value of the range here",
                        "lte": "Enter highest value of the range here"
                    }
                }
            }
        }

        // query data for certain time period
        GET news_headlines/_search
        {
            "query": {
                "range": {
                    "date": {
                        "gte": "2015-06-20",
                        "lte": "2015-09-22"
                        }
                }
            }
        }
        ```
    * ***Aggregations*** summarizes the data as metrics, statistics, and other analytics. So, we don't get the documents themselves here.
        ```js
        // syntax
        GET enter_name_of_the_index_here/_search
        {
            "aggs": {
                "name your aggregation here": {
                    "specify aggregation type here": {
                            "field": "name the field you want to aggregate here",
                            "size": state how many buckets you want returned here
                        }
                    }
                }
        }

        // query data for certain time period
        GET news_headlines/_search
        {
            "aggs": {
                "by_category": {
                    "terms": {
                        "field": "category",
                        "size": 100
                    }
                }
            }
        }
        ```
* A combination of query and aggregation request: Search for the most significant term in a category
    ```js
    GET enter_name_of_the_index_here/_search
    {
        "query": {
            "match": {
               "Enter the name of the field": "Enter the value you are looking for"
            }
        },
        "aggregations": {
            "Name your aggregation here": {
                "significant_text": {
                    "field": "Enter the name of the field you are searching for"
                }
            }
        }
    }
    ```
* **Precision and Recall:** By default, the `match` query uses `OR` logic. In the query below, there are a few articles slightly irrelevant to `"Khloe Kardashian Kendall Jenner"` because a few hits mention the wrong Kardashian. `OR` logic results in higher number of hits, thereby ***increasing recall***. However, the hits are loosely related to the query and ***lowering precision*** as a result.
    * Syntax:
        ```js
        GET enter_name_of_index_here/_search
        {
            "query": {
                "match": {
                    "Specify the field you want to search": {
                        "query": "Enter search terms"
                    }
                }
            }
        }
        ```

    * Example:
        ```js
        GET news_headlines/_search
        {
            "query": {
                "match": {
                    "headline": {
                        "query": "Khloe Kardashian Kendall Jenner"
                    }
                }
            }
        }
        ```
* We can specify the `operator` type to `AND` but we get too few results this time. Even though we increase the precision, we get lower recall. To fine-tune the precision/recall ratio, we can use `minimum_should_match` field to restrict the minimum # of search terms to match. Setting it to 3 for example gives better result since at least 3 words (could be 4 as well) from the query should match in the `headline`s.
* Entire code:
    ```js
    GET news_headlines/_search

    // get the total number of hits
    GET news_headlines/_search
    {
        "track_total_hits": true
    }

    // query data for certain time period
    GET news_headlines/_search
    {
        "query": {
            "range": {
                "date": {
                    "gte": "2015-06-20",
                    "lte": "2015-09-22"
                }
            }
        }
    }

    // aggregations by category
    GET news_headlines/_search
    {
        "aggs": {
            "by_category": {
                "terms": {
                    "field": "category",
                    "size": 100
                }
            }
        }
    }

    // query + aggregations
    GET news_headlines/_search
    {
        "query": {
            "match": {
                "category": "ENTERTAINMENT"
            }
        },
        "aggregations": {
            "popular_words_in_entertainment": {
                "significant_text": {
                    "field": "headline"
                }
            }
        }
    }

    // query certain words (default operator: OR logic)
    GET news_headlines/_search
    {
        "query": {
            "match": {
                "headline": {
                    "query": "Khloe Kardashian Kendall Jenner"
                }
            }
        }
    } // fetches 955 results. too large!

    // query certain words (operator: AND logic)
    GET news_headlines/_search
    {
        "query": {
            "match": {
                "headline": {
                    "query": "Khloe Kardashian Kendall Jenner",
                    "operator": "and" // i want all 4 words
                }
            }
        }
    } // fetches only 1 result. too strict!

    // query certain words (specify # of search terms to match)
    GET news_headlines/_search
    {
        "query": {
            "match": {
                "headline": {
                    "query": "Khloe Kardashian Kendall Jenner",
                    "minimum_should_match": 3 // at least 3 search terms
                }
            }
        }
    } // fetches 6 hits.
    ```
## 1.3. Full-Text & Combined Queries
### 1.3.1. Theory
* Since `match` query doesn't care about word order, in a lyric search, let's say, the results could be completely irrelevant. Thus, `match_phrase` is more successful retrieving more relevant and exact queries. Since it is looking for exact queries, recall is a bit lower I guess.
* When the `match_phrase` parameter is used, all hits must meet the following criteria:
    * the search terms "Shape", "of", and "you" must appear in the field headline,
    * the terms must appear in that order,
    * the terms must appear next to each other.
* Cool Observation: When I tried the same query (the song _"Shape of You"_) with `match` with `AND` operator instad `match_phrase`, I got 5 hits instead of 3 because the other 2 headlines contained stuff like `Shape of your body...`. So, it seems that `match_phrase` is indeed better at phrases.
* When designing a `query`, you don't always know the context of a user's search. When a user searches for "Michelle Obama", the user could be searching for statements written by Michelle Obama or articles written about her. To accommodate these contexts, we can write a `multi_match query`, which searches for terms in multiple fields. The `multi_match query` runs a `match query` on multiple fields and calculates a score for each field. Then, it assigns the highest score among the fields to the document. This score will determine the ranking of the document within the search results.
    * Elasticsearch will search for results with "Michelle" `OR` "Obama" among the specified fields. So, ***expect high recall!***
    * Thus, to match phrases like in `match_phrase`, we need to specify that the `type` of the `multi_match` we are querying is `phrase`. How? See the practice codes.
* **Per-field Boosting:** We can boost a field we wanna put more emphasis on. With just a carat `^` symbol, we can boost a field.
* **Combined Queries:** If we want "Michelle Obama" in headlines, and the article is about "POLITICS", and they are from 2016, what do we do? We use `bool query`. Syntax:
    ```js
    GET name_of_index/_search
    {
        "query": {
            "bool": {
                "must": [
                    {One or more queries can be specified here. A document MUST match all of these queries to be considered as a hit.}
                ],
                "must_not": [
                    {A document must NOT match any of the queries specified here. If it does, it is excluded from the search results.}
                ],
                "should": [
                    {A document does not have to match any queries specified here. However, if it does match, this document is given a higher score.}
                ],
                "filter": [
                    {These filters(queries) place documents in either yes or no category. Ones that fall into the yes category are included in the hits.}
                ]
            }
        }
    }
    ```
### 1.3.2. Practice: Some More Advanced Stuff
```js
// searching for a phrase, not search terms with "match_phrase"
GET news_headlines/_search
{
  "query": {
    "match_phrase": {
      "headline": {
        "query": "Shape of you"
      }
    }
  }
}

// multiple match with equal weights on the fields with "multi_match"
GET news_headlines/_search
{
  "query": {
    "multi_match": {
      "query": "Michelle Obama",
      "fields": [
        "headline",
        "short_description",
        "authors"
      ]
    }
  }
}

// multiple match with "headline" field boosted #1
GET news_headlines/_search
{
  "query": {
    "multi_match": {
      "query": "Michelle Obama", // query logic: OR
      "fields": [
        "headline^2",
        "short_description",
        "authors"
      ]
    }
  }
}  // gives 5k hits.

// multi_match with "headline" field boosted #2
GET news_headlines/_search
{
  "query": {
    "multi_match": {
      "query": "party planning", // query logic: OR
      "fields": [
        "headline^2",
        "short_description"
      ]
    }
  }
}  // gives 2951 hits.

// multi_match search for a phrase this time (still boosted)
GET news_headlines/_search
{
  "query": {
    "multi_match": {
      "query": "party planning",
      "fields": [
        "headline^2",
        "short_description"
      ],
      "type": "phrase"
    }
  }
}  // gives 6 hits. much lower recall but good precision.

// we'll list the headlines mention "Michelle Obama" as a phrase and aggregate them by category
GET  news_headlines/_search
{
  "query": {
    "match_phrase": {
      "headline": "Michelle Obama"
    }
  },
  "aggregations": {
    "category_mentions": {
      "terms": {
        "field": "category",
        "size": 100
      }
    }
  }
}

// combined query: headline + category (must)
GET news_headlines/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "headline": "Michelle Obama"
          }
        },
        {
          "match": {
            "category": "POLITICS"
          }
        }
      ]
    }
  }
}

// combined query: exclude one of the categories (must_not)
GET news_headlines/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "headline": "Michelle Obama"
          }
        }
      ],
      "must_not": [
        {
          "match": {
            "category": "WEDDNGS"
          }
        }
      ]
    }
  }
}

// combined query: nice to have if an article's category is a certain value (should; gives higher score to it)
GET news_headlines/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "headline": "Michelle Obama"
          }
        }
      ],
      "should": [
        {
          "match": {
            "category": "BLACK VOICES"
          }
        }
      ]
    }
  }
} // # of hits doesn't change but ordering does!

// combined query: articles between a specific date (filter)
GET news_headlines/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "headline": "Michelle Obama"
          }
        }
      ],
      "should": [
        {
          "match": {
            "category": "BLACK VOICES"
          }
        }
      ],
      "filter": [
        {
          "range": {
            "date": {
              "gte": "2014-03-25",
              "lte": "2016-03-25"
            }
          }
        }
      ]
    }
  }
} // hits drop to 33 since filtered.
```