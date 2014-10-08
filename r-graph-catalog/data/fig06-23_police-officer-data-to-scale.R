library(ggplot2)
library(gridExtra)

this_base <- "fig06-23_police-officer-data-to-scale"

my_data <- data.frame(
  county = c("Atlantic", "Bergen", "Burlington", "Camden", "Cape May", 
             "Cumberland", "Essex", "Gloucester", "Hudson", "Hunterdon", 
             "Mercer", "Middlesex", "Monmouth", "Morris", "Ocean",
             "Passiac", "Salem", "Somerset", "Sussex", "Union", "Warren"),
  rate = c(3.8, 2.4, 1.7, 2.4, 3.5, 1.9, 
           3.9, 2.0, 3.5, 1.3, 2.7, 2.1, 2.3, 
           2.2, 1.9, 2.2, 1.5, 2.0, 1.2, 2.9, 1.4),
  number = c(899, 1997, 686, 1219, 341, 263, 
             2950, 484, 1912, 154, 902, 1498, 1341, 995, 
             905, 1037, 104, 528, 175, 1420, 135))

my_data$county <- 
  factor(my_data$county, 
         levels = c("Atlantic", "Bergen", "Burlington", "Camden", "Cape May", 
                    "Cumberland","Essex", "Gloucester", "Hudson", "Hunterdon", 
                    "Mercer", "Middlesex", "Monmouth", "Morris", "Ocean", 
                    "Passiac", "Salem", "Somerset", "Sussex", "Union", 
                    "Warren"))

p1 <- ggplot(my_data, aes(x = reorder(county, number), y = number, width = 0.5)) +
  geom_bar(stat = "identity", fill = "grey70", colour = "black") + 
  scale_y_continuous(breaks = seq(0, 3500, 500), limits = c(0, 3500),
                     expand = c(0, 0)) +
  coord_flip() +
  ggtitle("Number of Police Officers by County, 1997") + 
  theme_bw() +
  theme(panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_line(colour = "grey60"),
        plot.title = element_text(face = "bold", size = 12),
        axis.title = element_blank())

p1

p2 <- ggplot(my_data, aes(x = reorder(county, number), y = rate, width = 0.5)) +
  geom_bar(stat = "identity", fill = "grey70", colour = "black") + 
  scale_y_continuous(breaks = seq(0, 4.5, 0.5), limits = c(0, 4.5),
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Rate per 1000") +
  ggtitle("Rate per 1000 Population, 1997") + 
  coord_flip() +
  theme_bw() +
  theme(panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_line(colour = "grey60"),
        plot.title = element_text(face = "bold", size = 12),
        axis.title.x = element_text(face = "bold"))


p3 <- arrangeGrob(p1, p2, ncol = 2,
                  main = textGrob("Fig 6.23 Police Officer Data to Scale", 
                                  just = "top", vjust = 0.75, 
                                  gp = gpar(fontsize = 17, 
                                            lineheight = 1, 
                                            fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 9, height = 7)

## pedantic: y axis tick marks between bars instead of centred at bars

