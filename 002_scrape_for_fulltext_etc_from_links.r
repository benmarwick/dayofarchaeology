#' Start with output from scraping for URLs, now pull full text
#' get text from each post using the URLs we just got

# make one big list of URLs
linksall <- unlist(links)
# make a data.frame to store the full text in 
# and get date and author of full text also
blogtext <- data.frame(text =  vector(length = length(linksall)),                                     
                       monthday = vector(length = length(linksall)),
                       year = vector(length = length(linksall)),
                       author = vector(length = length(linksall))
                       )

# make a list to store comments for each blog post
names <- vector("list", length = length(linksall))

# loop over the URLs to pull full text, etc. from each URL
# includes error handling in case a field is empty, etc.
for(i in 1:length(linksall)){
  # track progress
  print(i)
  # get URL
  blogdata <- htmlParse(getURI(linksall[[i]]))
  # get text from URL
  result <- try(
    blogtext[i,1] <- xpathSApply(blogdata, "//*/section[@class='entry']", xmlValue)
  ); if(class(result) == "try-error") next;
  # get date of blog post
  # first month and day
  result <- try(
    blogtext[i,2] <- strsplit(xpathSApply(blogdata, "//*/abbr[@class='date time published']", xmlValue), ",")[[1]][1],
  ); if(class(result) == "try-error") next;
  # and then year, and remove excess white space
  result <- try(
    blogtext[i,3] <- gsub("\\s","", strsplit(xpathSApply(blogdata, "//*/abbr[@class='date time published']", xmlValue), ",")[[1]][2])
  ); if(class(result) == "try-error") next;
  # and author
  result <- try(
    blogtext[i,4] <- xpathSApply(blogdata, "//*/span[@class='fn']", xmlValue)
  ); if(class(result) == "try-error") next;
   # and the names of the commenters 
   result <- try(
     commenters[[i]] <- xpathSApply(blogdata, "//*/span[@class='name']", xmlValue)
  ); if(class(result) == "try-error") next;
  
}

# add columns of URLs to the fulltext post
blogtext$url <- linksall
