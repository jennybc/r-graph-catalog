#' ---
#' title: SCATTERPLOT LIFEEXP AGAINST YEAR
#' ---

library(ggplot2)

this_base <- "0014_scatterplot-lifeexp-against-year"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = year, y = lifeExp)) +
  geom_point()

p

ggsave(paste0(this_base, ".png"), p, width = 5, height = 5)
