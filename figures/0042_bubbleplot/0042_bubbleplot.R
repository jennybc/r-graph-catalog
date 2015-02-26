#' ---
#' title: BUBBLEPLOT
#' ---

library(ggplot2)
library(downloader) # download()

this_base <- "0042_bubbleplot"

## use an excerpt of the Gapminder data
## prepared and posted by Jenny Bryan for use in teaching
gDat_url <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gDat_url)
str(gDat)

download("https://raw.githubusercontent.com/jennybc/ggplot2-tutorial/master/gapminder-country-colors.tsv", 
         "gapminder-country-colors.tsv")

country_colors <- read.delim("gapminder-country-colors.tsv",
                             colClasses = list(color = "character"))
str(country_colors)

gDat <- droplevels(subset(gDat, continent != "Oceania"))
country_colors <- droplevels(subset(country_colors, continent != "Oceania"))

jYear <- 2007 # this can obviously be changed
jPch <- 21
jDarkGray <- 'grey20'
jXlim <- c(150, 115000)
jYlim <- c(16, 100)

## handy for ggplot2 scale_fill_manual()
jColors <- country_colors$color
names(jColors) <- country_colors$country

p <- ggplot(subset(gDat, year == jYear), aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = sqrt(pop/pi)), pch = jPch, color = jDarkGray,
             show_guide = FALSE) + 
  facet_wrap(~ continent) +
  scale_x_log10(limits = jXlim) + ylim(jYlim) +
  scale_size_continuous(range=c(1,40)) +
  coord_fixed(ratio = 1/43) +
  aes(fill = country) + 
  scale_fill_manual(values = jColors) +
  theme_bw() + 
  theme(strip.text = element_text(size = rel(1.1)))

p

ggsave(paste0(this_base, ".png"), p, width = 8, height = 7)
