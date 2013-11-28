#' Get names of commenters on blog posts and do
#' some basic sna

# Make edge lists for further analysis

# get table of commenters' names and URLs of posts they comment on
names(commenters) <- blogtext$url
commenters_url <- stack(commenters)
names(commenters_url) <- c("commenter", "url")

# get table of commenters' names and authors of posts they comment on
names(commenters) <- blogtext$author
commenters_author<- stack(commenters)
names(commenters_author) <- c("commenter", "author")


# plots

require(igraph)
g <- graph.data.frame(commenters_author, directed=TRUE)
plot(g,
     layout=layout.fruchterman.reingold,  # the layout method. see the igraph documentation for details
     main='Day of Archaeology blog comments \n(edges point to post author)',	#specifies the title
     vertex.size = 5,
     vertex.label.dist=0.1,			#puts the name labels slightly off the dots
     vertex.color = "red",
     vertex.frame.color='red', 		#the color of the border of the dots 
     vertex.label.color='black',		#the color of the name labels
     vertex.label.font=1,			#the font of the name labels
     vertex.label=V(g)$name,		#specifies the lables of the vertices. in this case the 'name' attribute is used
     vertex.label.cex=1,			#specifies the size of the font of the labels. can also be made to vary
     vertex.label.family = "sans",
     edge.arrow.size = 0.4,
     edge.color = "blue",
     layout=layout.fruchterman.reingold
)


# for Gephi
# this line will export from R and make the file 'g.graphml' 
# in the working directory, ready to open with Gephi
write.graph(g, file="g.graphml", format="graphml")

# export edge list to CSV for other software
write.csv(commenters_author, file = 'commenters_author.csv')


