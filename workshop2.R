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

# filter the summary to get the 10 countries with the lowest mean HDI 
hdi_summary_low <- hdi_summary %>% 
  filter(rank(mean_index) < 11)
hdi_summary_low

# plot these low mean countries
hdi_summary_low %>% 
  ggplot() +
  geom_point(aes(x = Country,
                 y = mean_index)) +
  geom_errorbar(aes(x = Country,
                    ymin = mean_index - se,
                    ymax = mean_index + se)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()


# now build a pipeline that takes the hdi data frame (6340 rows) through to the plot with no intermediates 
hdi_summary <- hdi3 %>%
  group_by(Country) %>%
  summarise(mean_index = mean(Index),
            n = length (Index),
            sd = sd(Index),
            se = sd/sqrt(n)) %>% 
  filter(rank(mean_index) < 11) %>% 
  ggplot() +
  geom_point(aes(x = Country,
                 y = mean_index)) +
  geom_errorbar(aes(x = Country,
                    ymin = mean_index - se,
                    ymax = mean_index + se)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()

  
  
## Section 2 ##
# use readLines() to view first few lines of data and help to decide on how we should read in the data 
file <- "http://www.ndbc.noaa.gov/view_text_file.php?filename=44025h2011.txt.gz&dir=data/historical/stdmet/"
readLines(file, n = 4)

# the data starts on line 3 
buoy44025 <- read_table(file, 
                        col_names = FALSE,
                        skip = 2)
# buoy44025 is the name of the buy this data is taken from 

view(buoy44025)


# use scan() to read in the appropriate lines and tidy the results 
# remove the # in front of YY
buoy <- scan(file, nlines = 1, what = character()) %>% 
  str_remove("#")
view(buoy)

# put in measurement values using str_replace 
buoy2 <- scan(file, nlines = 1, what = character()) %>% 
  str_remove("#") %>%
  str_replace("/", "per")
view(buoy2)

# combine into a single vector with paste()
combined <- paste(buoy, buoy2, sep = "_")

# make combined vector the names of headings 
names(buoy44025) <- combined
names(buoy44025)
