#' ---
#' title: SCATTERPLOT LOG TRANSFORM
#' ---

library(ggplot2)

this_base <- "0005_scatterplot-log-transform"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

# quick and dirty 
# p <- ggplot(gDat, aes(x = log10(gdpPercap), y = lifeExp)) +
#   geom_point()

# a better way to log transform
p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

p

ggsave(paste0(this_base, ".png"), p, width = 5, height = 5)
