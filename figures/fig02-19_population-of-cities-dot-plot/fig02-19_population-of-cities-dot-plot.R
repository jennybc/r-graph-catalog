library(ggplot2)

this_base <- "fig02-19_population-of-cities-dot-plot"

my_data <- data.frame(
  population = c(60, 63, 75, 80, 80, 80, 90, 120, 
                 130, 140, 145, 160, 180, 200, 210, 
                 220, 250, 255, 380, 690, 900, 1100),
  city = c('Edinburgh', 'Stockholm', 'Florence', 'Genoa', 'Turin',
           'Warsaw', 'Copenhagen', 'Lisbon', 'Palermo', 'Madrid',
           'Berlin', 'Rome', 'Petersburgh', 'Venice', 'Dublin', 
           'Amsterdam', 'Moscow', 'Vienna', 'Naples', 'Paris', 
           'Constantinople', 'London'))

p <- ggplot(my_data, aes(x = population, y = reorder(city, population))) + 
  geom_point(size = 3) +
  scale_x_continuous(breaks = seq(200, 1100, 200), limits = c(0, 1150),
                     expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0.5)) +
  labs(x = "Population (thousands)", y = NULL) +
  ggtitle("Fig 2.19 Population of Cities: Dot Plot") + 
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey50"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.title.x = element_text(size = 13),
        axis.ticks.y = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 6)

## pedantic: missing tick marks at top of plot

