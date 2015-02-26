#' ---
#' title: SCATTERPLOT FITTED LINE
#' ---

library(ggplot2)

this_base <- "0010_scatterplot-fitted-line"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  geom_smooth(lwd = 3, se = FALSE, method = "lm")

p

ggsave(paste0(this_base, ".png"), p, width = 5, height = 5)
