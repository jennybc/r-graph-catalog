library(ggplot2)
library(reshape2) # melt()
library(grid) # unit()

this_base <- "fig02-13_energy-data-grouped-bar-chart"

my_data <- data.frame(
  year = factor(c(77, 78, 79, 80, 81, 82, 83, 84, 85, 86)),
  us = c(1320, 1280, 1350, 1400, 1470, 1420, 1440, 1580, 1520, 1610),
  japan = c(405, 405, 480, 500, 490, 495, 480, 480, 500, 530),
  germany = c(220, 225, 290, 320, 300, 280, 260, 240, 220, 225),
  other = c(1280, 1195, 1310, 1390, 1270, 1200, 1100, 1100, 1040, 1080))

# reshape my_data into long form
my_data_long <- melt(my_data, id.vars = c("year"))

p <- ggplot(my_data_long, aes(x = year, y = value, fill = variable)) +
  # to hide legend slashes, first graph bars with no outline and add legend
  # then graph bars again with outline but blank legend (R Cookbook)
  geom_bar(stat="identity", position = "dodge", width = 0.7) +
  geom_bar(stat="identity", position = "dodge", colour = "black", width = 0.7, 
           show_guide = FALSE) +
  scale_y_continuous(breaks = seq(0, 1800, 200), limits = c(0, 1800), 
                     expand = c(0, 0)) +
  scale_fill_manual("variable" , 
                    values = c('grey40', '#FFFFFF', '#000000', 'grey60'), 
                    labels = c("US", "Japan", "West Germany", 
                               "All Other OECD")) +
  labs(x = "Year", y = "Millions of Gallons") +
  ggtitle("Fig 2.13 Energy Data: Grouped Bar Chart") + 
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.title = element_text(face = "bold"),
        legend.position = "top",
        legend.title = element_blank(),
        legend.key.size = unit(0.4, "cm"),
        legend.key = element_rect(fill = "black"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 5)

## pedantic: black border around legend key and tick marks between groups
## note: my_data is estimated

