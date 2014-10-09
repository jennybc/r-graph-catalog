library(ggplot2)

this_base <- "fig02-05_three-dimensional-pie-data-two-dimensional-pie-chart"

my_data <- data.frame(
  variable = c("A", "B", "C", "D"),
  value = c(0.2, 0.2, 0.2, 0.4))

p <- ggplot(my_data, aes(x = factor(1), y = value, fill = variable)) +
  geom_bar(width = 1, colour = "black", stat = "identity") + 
  coord_polar(theta = "y") +
  guides(fill = FALSE) + 
  scale_fill_manual(values = c('grey40', 'grey20', 'white', 'grey80')) +
  ggtitle("Fig 2.5 Three-Dimensional Pie Data:\nTwo Dimensional Pie Chart") + 
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.border = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold"),
        axis.title = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

