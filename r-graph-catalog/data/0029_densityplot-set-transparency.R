#' ---
#' title: DENSITYPLOT SET TRANSPARENCY
#' ---

library(ggplot2)

this_base <- "0029_densityplot-set-transparency"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = lifeExp, fill = continent)) + 
  geom_density(alpha = 0.2)

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
