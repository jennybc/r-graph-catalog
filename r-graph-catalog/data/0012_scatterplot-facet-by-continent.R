#' ---
#' title: SCATTERPLOT FACET BY CONTINENT
#' ---

library(ggplot2)

this_base <- "0012_scatterplot-facet-by-continent"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = (1/3), size = 3) +
  facet_wrap(~ continent) +
  scale_x_log10()

p

ggsave(paste0(this_base, ".png"), p, width = 5, height = 5)
