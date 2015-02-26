#' ---
#' title: SCATTERPLOT MAP CONTINENT TO COLOUR
#' ---

library(ggplot2)

this_base <- "0006_scatterplot-map-continent-to-colour"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()

p

ggsave(paste0(this_base, ".png"), p, width = 5, height = 5)
