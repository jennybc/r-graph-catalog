library(ggplot2)
library(gridExtra) #arrangeGrob

this_base <- "fig06-32_population-of-cities"

my_data <- data.frame(
  city = c("New York", "Los Angeles", "Chicago", "Houston", "Philadelphia", 
           "San Diego", "Detroit", "Dallas", "Phoenix", "San Antonio"),
  population_1990 = c(7322564, 3485398, 2783726, 1630553, 1585577, 
                      1110549, 1027974, 1006877, 983403, 935933),
  population_2000 = c(8008278, 3694820, 2896016, 1953631, 1517550, 
                      1223400, 951270,  1188580, 1321045, 1144646))

p1 <- ggplot(my_data, aes(x = population_2000/1000, 
                       y = reorder(city, population_2000))) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 8000, 2000),limits = c(0, 9000)) +
  labs(x = "2000 Population (thousands)", y = NULL) +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60"))

p2 <- ggplot(my_data, aes(x = population_1990/1000, 
                       y = reorder(city, population_1990))) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 8000, 2000), limits = c(0, 9000)) +
  labs(x = "1990 Population (thousands)", y = NULL) +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60"),
        panel.grid.minor.x = element_blank()) 


p3 <- arrangeGrob(
  p1, p2, nrow = 2,
  main = textGrob("Fig 6.32 Population of Cities", 
                  just = "top", vjust = 0.75, gp = gpar(fontsize = 16, 
                                                        lineheight = 1, 
                                                        fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 5, height = 7)

