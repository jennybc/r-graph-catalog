#' ---
#' title: STRIPPLOT JITTER
#' ---

library(ggplot2)

this_base <- "0021_stripplot-jitter"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_jitter()

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
