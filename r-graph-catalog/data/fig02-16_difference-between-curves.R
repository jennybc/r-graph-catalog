library(ggplot2)
library(reshape2)

this_base <- "fig02-16_difference-between-curves"

my_data <- data.frame(
  curve1 = curve(1/x^2, from = 0.5, to = 3, ylim = c(0, 5)),
  curve2 = curve(1/x^2 + 0.6, from = 0.5, to = 3.0 , ylim = c(0, 5))$y)

names(my_data) <- c("x", "curve1", "curve2")

my_data_long <- melt(my_data, "x", c("curve1", "curve2"), "curve")

p <- ggplot(my_data_long, aes(x = x, y = value, group = curve)) +
  geom_line() +
  scale_x_continuous(breaks = seq(0.5, 3, 0.5), limits = c(0.5, 3)) +
  scale_y_continuous(breaks = seq(0, 5, 1), limits = c(0, 5)) +
  labs(x = "x", y = "y") + 
  ggtitle("Fig 2.16 Difference Between Curves") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

