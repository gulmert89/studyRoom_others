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
* .