#' ---
#' title: HISTOGRAM STACKED
#' ---

library(ggplot2)

this_base <- "0027_histogram-stacked"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = lifeExp, fill = continent)) + 
  geom_histogram(position = "stack") # default

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
