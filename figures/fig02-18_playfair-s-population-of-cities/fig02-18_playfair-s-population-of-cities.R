library(ggplot2)

this_base <- "fig02-18_playfair-s-population-of-cities"

my_data <- data.frame(
  population = c(60, 63, 75, 80, 80, 80, 90, 120, 
                 130, 140, 145, 160, 180, 200, 210, 
                 220, 250, 255, 380, 690, 900, 1100),
  city = c('Edinburgh', 'Stockholm', 'Florence', 'Genoa', 'Turin',
           'Warsaw', 'Copenhagen', 'Lisbon', 'Palermo', 'Madrid',
           'Berlin', 'Rome', 'Petersburgh', 'Venice', 'Dublin', 
           'Amsterdam', 'Moscow', 'Vienna', 'Naples', 'Paris', 
           'Constantinople', 'London'))

# include helper variables
my_data$row <- c(rep("row1", 11), rep("row2", 11)) # to organize into 2 rows 
my_data$pos <- rep(11:1, 2) # specify x coord

p <- ggplot(my_data, aes(x = pos, y = row, size = population)) +
  geom_point(aes(size = population), shape = 21, fill = "white", 
             show_guide = FALSE) +
  geom_text(aes(label = city), vjust = 2.7, hjust = 0.95, angle = 40, 
            size = 4) +
  scale_size_continuous(range = c(3, 12)) +
  ggtitle("Fig 2.18 Playfair's Population of Cities") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 5)

