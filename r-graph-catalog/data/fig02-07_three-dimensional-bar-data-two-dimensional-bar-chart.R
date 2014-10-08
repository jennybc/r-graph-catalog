library(ggplot2)

this_base <- "fig02-07_three-dimensional-bar-data-two-dimensional-bar-chart"

my_data <- data.frame(
  variable = c("A", "B", "C", "D"),
  value = c(2, 4, 6, 8))

p <- ggplot(my_data, aes(x = variable, y = value)) + 
  geom_bar(stat = "identity", fill = "grey50", colour = "black", width = 0.4) +
  scale_y_continuous(breaks = seq(0, 9, 1), limits = c(0, 9), 
                     expand = c(0, 0)) +
  ggtitle("Fig 2.7 Three Dimensional Bar Data:\nTwo-Dimensional Bar Chart") + 
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.title = element_blank(),
        axis.ticks.x = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 4)

## pedantic: did not include tick mark between bars
