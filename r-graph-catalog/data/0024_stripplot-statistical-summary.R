#' ---
#' title: STRIPPLOT STATISTICAL SUMMARY
#' ---

library(ggplot2)

this_base <- "0024_stripplot-statistical-summary"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(reorder(x = continent, lifeExp), y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1), alpha = 1/4) +
  stat_summary(fun.y = median, colour = "red", geom = "point", size = 5) +
  xlab("continent")

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
