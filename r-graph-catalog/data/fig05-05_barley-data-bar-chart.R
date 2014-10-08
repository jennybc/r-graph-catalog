library(ggplot2)
library(grid) #unit()

this_base <- "fig05-05_barley-data-bar-chart"

my_data <- read.delim(paste0(this_base, ".tsv"))

my_data$variety <- factor(my_data$variety,
                       levels = c("Svansota", "No. 462", "Manchuria", 
                                  "No. 475", "Velvet", "Peatland",
                                  "Glabron", "No. 457", 
                                  "Wisconsin No. 38", "Trebi"))
my_data$site <- factor(my_data$site,
                    levels = c("Waseca", "Crookston", "Morris",
                               "University Farm", "Duluth", "Grand Rapids"))

p <- ggplot(my_data, aes(x = variety, y = yield, group = year, width = 0.5)) +
  geom_bar(stat = "identity", fill = 'grey80', colour = 'black') +
  facet_wrap(site ~ year, ncol = 2) +
  coord(ylim = c(10,70)) +
  coord_flip() +
  scale_y_discrete(breaks = seq(20, 60, 10)) + 
  labs(x = NULL, y = "Barley Yield (bushels/acre)") +
  ggtitle("Fig 5.5 Barley Data: Bar Chart") + 
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.margin = unit(0, "cm"),
        plot.title = element_text(size = rel(1.1), face = "bold", vjust = 2),
        strip.background = element_rect(fill = "white"),
        axis.ticks.y = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 9)

## pedantic: axis ticks and text on top, year labels on top instead of in facets, 
## zoom in on x axis range c(10, 70), y axis labels on right side

