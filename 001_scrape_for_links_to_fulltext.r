#' Get URLs to blog post full text for all posts
#' by scraping them out of each page of the
#' main blog aggregator

library(RCurl)
library(XML)

n <- 60 # determined by inspecting the first page
# pre-allocate list to fill
links <- vector("list", length = n)
for(i in 1:n){
  # track progress by showing the iteration we're up to
  print(i)
  # get all content on the i-th page of the main blog list
  blogdata <- htmlParse(getURI(paste0("http://www.dayofarchaeology.com/page/", i+1,"/")))
  # extract links for all posts
  links[[i]] <- unname(xpathSApply(blogdata,"//h2/a/@href"))
}