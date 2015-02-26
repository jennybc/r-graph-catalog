#' ---
#' title: SCATTERPLOT LIFEEXP AGAINST YEAR CONNECT COUNTRIES
#' ---

library(ggplot2)

this_base <- "0017_scatterplot-lifeexp-against-year-connect-countries"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

p <- ggplot(gDat, aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_line(aes(group = country)) +
  facet_wrap(~ continent)

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 7)
