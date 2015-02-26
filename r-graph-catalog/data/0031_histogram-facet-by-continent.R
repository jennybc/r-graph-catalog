#' ---
#' title: HISTOGRAM FACET BY CONTINENT
#' ---

library(ggplot2)

this_base <- "0031_histogram-facet-by-continent"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(subset(gDat, continent != "Oceania"),
            aes(x = lifeExp, fill = continent)) + 
  geom_histogram() +
  facet_grid(continent ~ .)

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)


