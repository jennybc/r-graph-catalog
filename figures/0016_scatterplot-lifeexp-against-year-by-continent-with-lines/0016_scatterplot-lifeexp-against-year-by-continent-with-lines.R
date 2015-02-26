#' ---
#' title: SCATTERPLOT LIFEEXP AGAINST YEAR BY CONTINENT WITH LINES
#' ---

library(ggplot2)

this_base <- "0016_scatterplot-lifeexp-against-year-by-continent-with-lines"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_smooth(se = FALSE, lwd = 1) +
  facet_wrap(~ continent)

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 7)
