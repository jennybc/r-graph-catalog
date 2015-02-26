#' ---
#' title: DENSITYPLOT FACET BY CONTINENT
#' ---

library(ggplot2)

this_base <- "0030_densityplot-facet-by-continent"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = lifeExp)) + 
  geom_density() + 
  facet_wrap(~ continent)

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
