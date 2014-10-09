library(ggplot2)

this_base <- "fig02-12_energy-data-all-other-oecd"

my_data <- data.frame(
  year = factor(77:86),
  us = c(1320, 1280, 1350, 1400, 1470, 1420, 1440, 1580, 1520, 1610),
  japan = c(405, 405, 480, 500, 490, 495, 480, 480, 500, 530),
  germany = c(220, 225, 290, 320, 300, 280, 260, 240, 220, 225),
  other = c(1280, 1195, 1310, 1390, 1270, 1200, 1100, 1100, 1040, 1080))

p <- ggplot(my_data, aes(x = year, y = other)) + 
  geom_bar(stat = "identity", fill = "grey80", colour = "black", width = 0.4) +
  scale_y_continuous(breaks=seq(0, 1600, 200), limits = c(0, 1600), 
                     expand = c(0, 0)) +
  labs(x = "Year", y = "Millions of Gallons") +
  ggtitle("Fig 2.12 Energy Data: All Other OECD") +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.title = element_text(face = "bold"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 4)

## pedantic: missing tick marks between the years
## note: my_data is estimated 
