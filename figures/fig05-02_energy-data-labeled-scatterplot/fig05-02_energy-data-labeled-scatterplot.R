library(ggplot2)
library(grid) # unit()
library(reshape2) # melt()
library(plyr) # revalue()

this_base <- "fig05-02_energy-data-labeled-scatterplot"

my_data <- data.frame(
  year = factor(1977:1986),
  us = c(1320, 1280, 1350, 1400, 1470, 1420, 1440, 1580, 1520, 1605),
  japan = c(405, 405, 480, 500, 490, 495, 480, 480, 500, 530),
  germany = c(220, 225, 290, 320, 300, 280, 260, 240, 220, 225),
  other = c(1280, 1195, 1310, 1390, 1270, 1200, 1100, 1100, 1040, 1080))

my_data_long <- melt(my_data, id.vars = "year",
                  measure.vars = c("us", "japan", "germany", "other"), 
                  variable.name = "country")
my_data_long$country_abbrev <-
  revalue(my_data_long$country, c("us" = "US", "japan" = "J",
                                  "germany" = "WG", "other" = "O"))

p <- ggplot(my_data_long, aes(x = year, y = value)) + 
  geom_text(aes(label = country_abbrev), hjust = 0.2, size = 3) +
  scale_x_discrete(breaks = seq(1978, 1986, 2)) +
  scale_y_continuous(breaks = seq(0, 1600, 200), limits = c(200, 1610)) +
  labs(x = "Year", y = "Millions of Gallons") +
  ggtitle("Fig 5.2 Energy Data: Labeled Scatterplot") + 
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_text(face = "bold"),
        axis.text = element_text(),
        legend.position = "bottom",
        legend.direction = "vertical",
        legend.key.width = unit(2, "lines"),
        legend.key.height = unit(0.5, "lines"),
        legend.title = element_blank()) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

## note: my_data is estimated 
