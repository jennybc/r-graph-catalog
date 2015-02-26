#' ---
#' title: THEME CALC
#' ---

library(ggplot2)
library(ggthemes)

this_base <- "0034_theme-calc"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_smooth(lwd = 2, se = FALSE) +
  scale_x_log10() +
  ggtitle("ggthemes::theme_calc()") + 
  theme_calc()

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)


ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
