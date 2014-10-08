library(ggplot2)
library(grid) # unit()
library(reshape2) # melt()

this_base <- "fig02-11_energy-data"

my_data <- data.frame(
  year = factor(c(77:86)),
  us = c(1320, 1280, 1350, 1400, 1470, 1420, 1440, 1580, 1520, 1610),
  japan = c(405, 405, 480, 500, 490, 495, 480, 480, 500, 530),
  germany = c(220, 225, 290, 320, 300, 280, 260, 240, 220, 225),
  other = c(1280, 1195, 1310, 1390, 1270, 1200, 1100, 1100, 1040, 1080))

my_data_long <- melt(my_data, id.vars = c("year"),
                  measure.vars = c("us", "japan", "germany", "other"), 
                  variable.name = "country", value.name = "value")

p <- ggplot(my_data_long, aes(x = year, y = value, fill = country, width = 0.6)) + 
  geom_bar(stat = "identity") +
  geom_bar(stat = "identity", colour = "black", width = 0.7, 
           show_guide = FALSE) +
  scale_y_continuous(breaks = seq(0, 3500, 500),
                     labels = c(0, "", 1000, "", 2000, "", 3000, ""),
                     limits = c(0, 4000), expand = c(0, 0)) +
  scale_fill_manual("variable" ,
                    values = c('grey40', '#FFFFFF','#000000','grey60'),
                    labels = c("US", "Japan", "West Germany", 
                               "All Other OECD")) +
  labs(x = NULL, y = "Millions of Gallons") +
  ggtitle("Fig 2.11 Energy Data") +
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
