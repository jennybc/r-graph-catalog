library(ggplot2)

this_base <- "fig03-05_position-along-a-common-scale"

my_data <- data.frame(
  variable = c("A", "B", "C", "D", "E"),
  value = c(0.23, 0.22, 0.195, 0.185, 0.17))

p <- ggplot(my_data, aes(x = value, y = reorder(variable, value))) + 
  geom_point() +
  scale_x_continuous(limit = c(0, 0.25), breaks = seq(0, 0.25, 0.05)) +
  ggtitle("Fig 3.5 Position along a Common Scale") +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_blank()) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 4)


