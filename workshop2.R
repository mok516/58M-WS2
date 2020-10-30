# load the tidyverse 
library(tidyverse)

# read in data file 
file <- "C:/Users/molsk/R work/Stage 3/58M-WS2/raw_data/Human-development-index.csv"

human <- read_table2(file)
# view data
view(human)
str(human)
# not tidy at all 
