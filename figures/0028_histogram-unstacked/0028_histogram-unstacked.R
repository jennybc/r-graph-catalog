#' ---
#' title: HISTOGRAM UNSTACKED
#' ---

library(ggplot2)

this_base <- "0028_histogram-unstacked"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = lifeExp, fill = continent)) + 
  geom_histogram(position = "identity")

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
