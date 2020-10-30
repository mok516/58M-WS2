# load the tidyverse 
library(tidyverse)

# read in data file 
file <- "C:/Users/molsk/R work/Stage 3/58M-WS2/raw_data/Human-development-index.csv"

human <- read_csv(file)
# view data
view(human)
str(human)
# not tidy at all 

# tidy with pivot_longer 
hdi <- human %>%
  pivot_longer(names_to = "Years",
               values_to = "HDI Index",
               cols = -c(Country, `HDI Rank (2018)`))

view(hdi)

