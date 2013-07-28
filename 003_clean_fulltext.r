#' clean out non-ASCII characters and formatting

# remove non-ASCII characters
Encoding(blogtext[,1]) <- "latin1" 
iconv(blogtext[,1], "latin1", "ASCII", sub="")
# remove newline character
blogtext[,1] <- gsub("\n","", blogtext[,1]) 
# save as CSV so others can use it
write.csv(blogtext, 'dayofarchaeology.csv')