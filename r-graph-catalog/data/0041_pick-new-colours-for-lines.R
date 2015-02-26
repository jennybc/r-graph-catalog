#' ---
#' title: PICK NEW COLOURS FOR LINES
#' ---

library(ggplot2)
library(RColorBrewer)

this_base <- "0041_pick-new-colours-for-lines"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")

x <- droplevels(subset(gDat, country %in% jCountries))

# reorder the country factor to reflect lifeExp in 2007
x <- transform(x, country = reorder(country, -1 * lifeExp, max))

# look at RColorBrewer color palettes
display.brewer.all()

# focus on qualitative palettes
display.brewer.all(type = "qual")

# pick some colors
jColors <- brewer.pal(n = 8, "Dark2")[seq_len(nlevels(x$country))]
names(jColors) <- levels(x$country)

# remake plot with new colors
p <- ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + 
  geom_point() +
  scale_color_manual(values = jColors)

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
