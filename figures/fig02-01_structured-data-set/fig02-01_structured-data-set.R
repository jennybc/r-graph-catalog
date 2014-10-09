library(ggplot2)

this_base <- "fig02-01_structured-data-set"

my_data <- data.frame(
  variable = paste("Item", 10:1),
  value = c(11.5, 6.5, 13.5, 8.5, 12.5, 7.5, 13.0, 8.0, 12.0, 7.0))

p <- ggplot(my_data, aes(x = factor(1), y = value)) +
  geom_bar(width = 1, colour = "black", fill = "white", stat = "identity") +
  geom_text(aes(x = 1.75, y = cumsum(value) - value/2, label = variable)) +
  coord_polar(theta = "y", start = pi/2) + 
  ggtitle("Fig 2.1 Structured Data Set") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())

p

ggsave(paste0(this_base, ".png"),
       p, width = 6, height = 5)

