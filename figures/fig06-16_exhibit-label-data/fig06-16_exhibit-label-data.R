library(ggplot2)
library(gridExtra)

this_base <- "fig06-16_exhibit-label-data"

my_data <- data.frame(before = c(115, 20, 58, 4, 3, 1),
                   after = c(116, 18, 36, 18, 4, 3),
                   level = c("0", "1", "2", "3", "4", "5"))

p1 <- ggplot(my_data, aes(x = level, y = before, fill = level)) +
  geom_bar(stat = "identity", colour = "black", width = 1, show_guide = FALSE) +
  scale_fill_manual(values = c("white", "white", "grey60", 
                               "white", "white", "white")) +
  scale_y_continuous(breaks = seq(0, 120, 20), limits = c(0, 120), 
                     expand = c(0, 0)) +
  labs(x = "Levels of Understanding", y = "Count") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "black", size = 0.5),
        panel.grid.major.x = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(colour = "black", size = 0.5),
        axis.ticks = element_blank())

p1	

p2 <- ggplot(my_data, aes(x = level, y = after, fill = level)) +
  geom_bar(stat = "identity", colour = "black", width = 1, show_guide = FALSE) +
  scale_fill_manual(values = c("white", "white", "grey60", 
                               "white", "white", "white")) +
  scale_y_continuous(breaks = seq(0, 120, 20), limits = c(0, 120), 
                     expand = c(0, 0)) +
  labs(x = "Levels of Understanding", y = "Count") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "black", size = 0.5),
        panel.grid.major.x = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(colour = "black", size = 0.5),
        axis.ticks = element_blank())

p2

# arrange plots together 
p3 <- arrangeGrob(p1, p2, ncol = 2,
                  main = textGrob("Fig 6.16 Exhibit Label Data", 
                                  just = "top", vjust = 0.75, 
                                  gp = gpar(lineheight = 1, fontface = "bold")))

p3

# must pass in p3 since arrangeGrob doesnt return ggplot object
ggsave(paste0(this_base, ".png"), 
       p3, width = 7, height = 3)


## note: my_data is estimated
