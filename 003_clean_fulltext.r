#' clean out non-ASCII characters and formatting

# remove non-ASCII characters
Encoding(blogtext[,1]) <- "latin1" 
iconv(blogtext[,1], "latin1", "ASCII", sub="")
# remove newline character
blogtext[,1] <- gsub("\n","", blogtext[,1]) 
# save as CSV so others can use it
write.csv(blogtext, 'dayofarchaeology.csv')

# a few quick summary statistics

# How many posts in total?
nrow(blogtext)

# How many words in total?
length(unlist(lapply(blogtext$text, function(i) strsplit(i, " ")[[1]])))

# how many authors in total?
length(unique(blogtext$author))

# How many posts in each year?
table(blogtext$year)

# how many words per year?
length(unlist(lapply(blogtext[blogtext$year == 2012,]$text, function(i) strsplit(i, " ")[[1]])))
length(unlist(lapply(blogtext[blogtext$year == 2013,]$text, function(i) strsplit(i, " ")[[1]])))

# how many authors per year?
length(unique(blogtext[blogtext$year == 2012,]$author))
length(unique(blogtext[blogtext$year == 2013,]$author))

# words per post per year
length(unlist(lapply(blogtext[blogtext$year == 2012,]$text, function(i) strsplit(i, " ")[[1]])))/table(blogtext$year)[[1]]
length(unlist(lapply(blogtext[blogtext$year == 2013,]$text, function(i) strsplit(i, " ")[[1]])))/table(blogtext$year)[[2]]

# plot distribution of words
# how many words per post?
wpp <- data.frame(
   words = unlist(lapply(blogtext$text, function(i) length(strsplit(i, " ")[[1]]))),
   year = blogtext$year, stringsAsFactors = FALSE)

# only look at 2012 and 2013
wpp <- wpp[wpp$year %in% c(2012, 2013),]

# function for labels
nlabels <- table(wpp$year)

#  To create the median labels, you can use by
meds <- round(c(by(wpp$words, wpp$year, mean)),0)

require(ggplot2)
ggplot(wpp, aes(as.factor(year), words, label=rownames(wpp))) +
  geom_violin() +
  geom_text(data = data.frame(), aes(x = names(meds) , y = meds, 
                                   label = paste("mean =", meds))) +
  xlab("Year")
