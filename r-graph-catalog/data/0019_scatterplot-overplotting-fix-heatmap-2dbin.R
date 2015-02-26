#' ---
#' title: SCATTERPLOT OVERPLOTTING FIX HEATMAP 2DBIN
#' ---

library(ggplot2)

this_base <- "0019_scatterplot-overplotting-fix-heatmap-2dbin"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp)) +
  geom_bin2d() +
  scale_x_log10()

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
