#' ---
#' title: BOXPLOT SPECIFY GROUPING VARIABLE
#' ---

library(ggplot2)

this_base <- "0032_boxplot-specify-grouping-variable"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = year, y = lifeExp)) + 
  geom_boxplot(aes(group = year))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
