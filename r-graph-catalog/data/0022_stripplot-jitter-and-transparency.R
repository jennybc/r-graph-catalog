#' ---
#' title: STRIPPLOT JITTER AND TRANSPARENCY
#' ---

library(ggplot2)

this_base <- "0022_stripplot-jitter-and-transparency"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/4)

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

