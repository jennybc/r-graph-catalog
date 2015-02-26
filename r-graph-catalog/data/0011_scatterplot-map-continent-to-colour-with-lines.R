#' ---
#' title: SCATTERPLOT MAP CONTINENT TO COLOUR WITH LINES
#' ---

library(ggplot2)

this_base <- "0011_scatterplot-map-continent-to-colour-with-lines"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_smooth(lwd = 2, se = FALSE) +
  scale_x_log10() +
  ggtitle("Life expectancy over time by continent")

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
