#' ---
#' title: STRIPPLOT NOTHING FANCY
#' ---

library(ggplot2)

this_base <- "0020_stripplot-nothing-fancy"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_point()

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
