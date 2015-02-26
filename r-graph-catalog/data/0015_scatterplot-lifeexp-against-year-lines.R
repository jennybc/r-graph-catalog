#' ---
#' title: SCATTERPLOT LIFEEXP AGAINST YEAR LINES
#' ---

library(ggplot2)

this_base <- "0015_scatterplot-lifeexp-against-year-lines"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_smooth(se = FALSE, lwd = 2) +
  geom_smooth(se = FALSE, lwd = 2, method = "lm", color = "orange")

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 6)
