# 1. Neo4j Fundamentals
* Source: [graphacademy](https://graphacademy.neo4j.com/)
## 1.1. Graph Thinking
* The Seven Bridges of Königsberg: **Leonhard Euler** was the inventor of graph theory back in 1736.
* Two elements of graphs:
    * **Nodes/Vertices:** Objects, entities or things like people (e.g. landmasses in Königsberg).
    * **Relationships/Edges:** e.g. bridges in Königsberg.
* **Directed Graphs:** Bi-directional or symmetric.
    * Michael `<---married_to--->` Sarah
* **Undirected Graphs:** Relationships with the same type but in opposing directions carry a different semantic meaning.
    * Michael `---loves--->` Sarah with $strength = 7$.
    * Sarah `---loves--->` Michael with $strength = 9$.
## 1.2. Property Graphs
* In neo4j, a node and an edge can have zero or more labels (Michael: `person`, `male`, `employee` etc.).
* Also, they can have key-value pair properties like,
    * Michael (node): `firstName: 'Michael'`
    * MARRIED_TO (edge): `date: '2022-06-15'`
* A sample `cypher` code:
    * traverse the Michael node to return the Sarah node:
    ```js
    MATCH (p:Person {firstName: 'Michael'})-[:MARRIED_TO]-(n) RETURN n;
    ```
    * traverse all relationship from the Michael node:
    ```js
    MATCH (p:Person {firstName: 'Michael'})--(n) RETURN n;
    ```
* **Q:** What two elements do you add to a node to make it represent the entities of your domain?
    * **A:** label & properties
* **Q:** What must relationships in Neo4j have?
    * **A:** a type & a direction
* **Native Graph Advantage**
    * **Index-free Adjacency:** Fewer index lookups, no table scans, reduced duplication of data.
* **Non-graph Databases to Graph**
    * **Q:** NoSQL datastores: As shown with the Northwind example, you learned that a Relational model can be implemented as a graph. What other NoSQL models have you learned about in this lesson that can be implemented as graphs to improve performance?
        * key-value store
        * document store
