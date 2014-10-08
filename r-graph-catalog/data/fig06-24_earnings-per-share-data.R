library(ggplot2)
library(gridExtra) #arrangeGrob

this_base <- "fig06-24_earnings-per-share-data"

my_data <- data.frame(
  earnings = c(20, 21.5, 23, 24.5, 26), 
  year = c(1999, 2000, 2001, 2002, 2003))

p1 <- ggplot(my_data, aes(x = earnings, y = year)) + 
  geom_rect(aes(xmin = rep(15, 5), xmax = rev(earnings), 
                ymin = rep(1998, 5), ymax = rev(c(1999:2003))), 
            fill = c("grey80", "grey70", "grey60", "grey50", "grey40"), 
            colour = "white") +
  geom_text(x = 15.5, y = my_data$year - 0.2, label = my_data$year, size = 4) +
  geom_text(x = my_data$earnings - 0.3, y = my_data$year - 0.2, 
            label = my_data$earnings, size = 4) +
  scale_x_continuous(limits = c(15, 26), expand = c(0, 0)) +
  scale_y_continuous(breaks = c(1999, 2003, 1), limits = c(1998, 2003),
                     expand = c(0, 0)) +
  ggtitle("Earnings per Share") +
  theme(plot.title = element_text(size = rel(1), face = "bold"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank()) 

p1

p2 <- ggplot(my_data, aes(x = year, y = earnings)) +
  geom_bar(stat = "identity", width = 0.4, fill = "grey60", colour = "black") +
  scale_y_continuous(breaks = seq(0, 30, 5), limits = c(0, 30),
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Earnings per Share") +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60"),
        panel.grid.minor = element_blank(),
        axis.title.y = element_text(face = "bold"),
        axis.ticks.x = element_blank())

p2

# arrange plots together 
p3 <- arrangeGrob(
  p1, p2, nrow = 2, heights = c(0.4, 0.6),
  main = textGrob("Fig 6.24 Earnings per Share Data", 
                  just = "top", vjust = 0.75, gp=gpar(fontsize = 14, 
                                                      lineheight = 1, 
                                                      fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

## pedantic: tick marks in between bars 


