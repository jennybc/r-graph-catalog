library(ggplot2)

this_base <- "fig01-01_similar-pie-wedges"

my_data <- data.frame(
  variable = c("A", "B", "C", "D", "E"), 
  value = c(23, 22, 19.5, 18.5, 17))

p <- ggplot(my_data, aes(x = factor(1), y = value)) +
  geom_bar(width = 1, colour = "black", fill = "white", stat = "identity") + 
  geom_text(aes(x = 1.7, y = cumsum(value) - 10, label = variable)) +
  coord_polar(theta = "y") + 
  ggtitle("Fig 1.1 Similar Pie Wedges") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold"),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

