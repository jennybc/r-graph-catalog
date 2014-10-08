library(ggplot2)
library(grid) #unit()

this_base <- "fig05-04_barley-data"

my_data <- read.delim(paste0(this_base, ".tsv"))

my_data$variety <- factor(my_data$variety,
                       levels = c("Svansota", "No. 462", "Manchuria", 
                                  "No. 475", "Velvet", "Peatland",
                                  "Glabron", "No. 457", 
                                  "Wisconsin No. 38", "Trebi"))
my_data$site <- factor(my_data$site,
                    levels = c("Waseca", "Crookston", "Morris",
                               "University Farm", "Duluth", "Grand Rapids"))

my_data$year <- factor(my_data$year, levels = c(1931, 1932))

p <- ggplot(my_data, aes(x = yield, y = variety, group = year)) +
  geom_point(aes(shape = year), size = 1.5) +
  facet_wrap(~ site, ncol = 1) +
  scale_shape_manual(values = c(3, 1)) +
  labs(x = "Barley Yield (bushels/acre)", y = NULL) +
  ggtitle("Fig 5.4 Barley Data") + 
  theme_bw() +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.margin = unit(0, "cm"),
        panel.grid.major.y = element_line(colour = "grey40"),
        plot.title = element_text(size = rel(1.1), face = "bold"),
        strip.text.x = element_text(size = 7),
        axis.text.y = element_text(size = 7),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 7),
        axis.title.x = element_text(size = 8),
        legend.title = element_blank(),
        legend.key = element_blank(),
        legend.position = "top",
        legend.text = element_text(size = 7),
        legend.key.height = unit(0,"line")) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 4, height = 9)

## pedantic: y axis labels should be on right side, legend keys should
## further apart, shading in strip label

