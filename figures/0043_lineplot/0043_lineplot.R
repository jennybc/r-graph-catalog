#' ---
#' title: LINEPLOT
#' ---

library(ggplot2)
library(downloader)

this_base <- "0043_lineplot"

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

p <- ggplot(gDat, aes(x = year, y = lifeExp, group = country)) +
  geom_line(lwd = 1, show_guide = FALSE) + 
  facet_wrap(~ continent) +
  aes(color = country) + 
  scale_color_manual(values = jColors) +
  theme_bw() + 
  theme(strip.text = element_text(size = rel(1.1)))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
