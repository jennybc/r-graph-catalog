#' ---
#' title: SCATTERPLOT SUBSET DATA REORDER LEGEND
#' ---

library(ggplot2)

this_base <- "0018_scatterplot-subset-data-reorder-legend"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

# ggplot() does not have a 'subset =' argument so do that 'on the fly' with 
# subset(..., subset = ...)

jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")

p <- ggplot(subset(gDat, country %in% jCountries),
       aes(x = year, y = lifeExp, 
           color = reorder(country, -1 * lifeExp, max))) +
  guides(color = guide_legend(title = "country")) +
  geom_line() + 
  geom_point()

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 7)
