library(ggplot2)
library(reshape2)
library(grid)

this_base <- "fig06-33_population-of-cities-conflicting-principles"

my_data <- data.frame(
  city = c("New York", "Los Angeles", "Chicago", "Houston", "Philadelphia", 
           "San Diego", "Detroit", "Dallas", "Phoenix", "San Antonio"),
  population_1990 = c(7322564, 3485398, 2783726, 1630553, 1585577, 
                      1110549, 1027974, 1006877, 983403, 935933),
  population_2000 = c(8008278, 3694820, 2896016, 1953631, 1517550, 
                      1223400, 951270,  1188580, 1321045, 1144646))

my_data_long <- melt(my_data, "city", c("population_1990", "population_2000"), 
                  "year", "population")

p <- ggplot(my_data_long, aes(x = value/1000, y = reorder(city, value))) +
  geom_point(aes(shape = year), size = 1.5) +
  scale_shape_manual(values = c(1,3), labels = c("1990", "2000")) +
  scale_x_continuous(breaks = seq(0, 8000, 2000), limits = c(0, 9000)) +
  labs(x = "Population (thousands)", y = NULL) +
  ggtitle("Fig 6.33 Population of Cities:\n Conflicting Principles") + 
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60"),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"),
        legend.title = element_blank(),
        legend.key = element_blank(),
        legend.position = "top",
        legend.text = element_text(size = 7),
        legend.key.height = unit(0,"line")) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 5, height = 7)

