#' Get URLs to blog post full text for all posts
#' by scraping them out of each page of the
#' main blog aggregator

library(RCurl)
library(XML)

n <- 100 # determined by inspecting the first page
# pre-allocate list to fill
links <- vector("list", length = n)
# get URLs from the first page separately, since the URL for
# the first page doesn't follow a pattern
links[[1]] <-  unname(xpathSApply(htmlParse(getURI("http://www.dayofarchaeology.com/")),"//h2/a/@href"))
for(i in 1:n){
  # track progress by showing the iteration we're up to
  print(i)
  # get all content on the i+1 th page of the main blog list
  blogdata <- htmlParse(getURI(paste0("http://www.dayofarchaeology.com/page/", i+1,"/")))
  # extract links for all posts
  links[[i+1]] <- unname(xpathSApply(blogdata,"//h2/a/@href"))
}

