library(ggplot2)

this_base <- "fig02-04_three-dimensional-pie-data-two-dimensional-bar-chart"

my_data <- data.frame(
  variable = c("A", "B", "C", "D"),
  value = c(0.2, 0.2, 0.2, 0.4))

p <- ggplot(my_data, aes(x = variable, y = value)) + 
  geom_bar(stat = "identity", fill = "grey80", colour = "black", width = 0.4) +
  scale_y_continuous(limits = c(0, 0.5), expand = c(0, 0)) +
  ggtitle("Fig 2.4 Three-Dimensional Pie Data:\nTwo Dimensional Bar Chart") + 
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.ticks.x = element_blank(),
        axis.title = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 4)

## pedantic: tick marks between bars

