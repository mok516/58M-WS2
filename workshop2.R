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
               values_to = "Index",
               cols = -c(Country, `HDI Rank (2018)`))

view(hdi)

# look for NA results with is.na()
hdi2 <- hdi[!is.na(hdi$Index),]
hdi3 <- hdi2[!is.na(hdi2$`HDI Rank (2018)`),]
view(hdi3)

# summarise data add summary column and add standard deviation and standard error 
hdi_summary <- hdi3 %>%
  group_by(Country) %>%
  summarise(mean_index = mean(Index),
            n = length (Index),
            sd = sd(Index),
            se = sd/sqrt(n))

