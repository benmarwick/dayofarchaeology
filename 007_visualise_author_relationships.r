#' Visualize author similarity using force-directed network graphs

#### network diagram using Fruchterman & Reingold algorithm
# static
library(igraph)
g <- as.undirected(graph.adjacency(topic_df_dist))
layout1 <- layout.fruchterman.reingold(g, niter=500)
plot(g, layout=layout1, edge.curved = TRUE, vertex.size = 1,  vertex.color= "grey", edge.arrow.size = 0, vertex.label.dist=0.5, vertex.label = NA)


# interactive in a web browser
devtools::install_github("d3Network", "christophergandrud")
require(d3Network)
d3SimpleNetwork(get.data.frame(g),width = 1500, height = 800, 
                textColour = "orange", linkColour = "red", 
                fontsize = 10, 
                nodeClickColour = "#E34A33", 
                charge = -100, opacity = 0.9, file = "d3net.html")
# find the html file in working directory and open in a web browser

# for Gephi
# this line will export from R and make the file 'g.graphml' 
# in the working directory, ready to open with Gephi
write.graph(g, file="g.graphml", format="graphml") 