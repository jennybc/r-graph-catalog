library(ggplot2)

this_base <- "fig01-02_similar-pie-wedges-dot-plot"

my_data <- data.frame(
  variable = c("A", "B", "C", "D", "E"),
  value = c(23, 22, 19.5, 18.5, 17))

p <- ggplot(my_data, aes(x = value, y = reorder(variable, value))) + 
  geom_point() +
  scale_x_continuous(limits = c(0, 25)) +
  ggtitle("Fig 1.2 Similar Pie Wedges: Dot Plot") + 
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 4)
