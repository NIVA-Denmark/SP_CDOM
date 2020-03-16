library(tidyr)
library(dplyr)

# ------------- read_sp function ---------------------------------
read_sp <- function( filename, identifier = "#DATA", colnames=c("wl","absorbance")){
  # read df as one column
  df <- read.csv(filename, fill = TRUE, header = F, stringsAsFactors = F)
  
  # find the row number with the identifier for the start if the actual data
  nstart<- which(df$V1==identifier) + 1
  
  # select the rows after this row
  df <- df %>%
    slice(nstart : n())
  
  # split the column into wavelength and absorbance
  df <- df %>%
    separate(col = "V1", sep = "\t", into = colnames)
  
  return(df)
}

# ------------- test  ---------------------------------

file<- "example/3.SP"
df <- read_sp(file)

fileout<-"example/text.txt"
write.table(df, file = fileout, sep = "\t", row.names = F, col.names = T, quote = F)

