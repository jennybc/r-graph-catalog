library(ggplot2)
library(gridExtra)

this_base <- "fig07-13_sales-data-full-scale-break"

set.seed(0)

x <- c(rnorm(400, 10, 3), runif(20, min = 0, max = 100))

my_data <- data.frame(value = sample(x, 420) * 1000, location = c(1:420))

p1 <- ggplot(my_data, aes(x = location, y = sort(value))) +
  geom_point(shape = 1) +
  scale_x_continuous(limits = c(0, 425)) +
  scale_y_continuous(breaks = seq(0, 80000, 20000)) +
  ggtitle("7.13 Sales Data: Full Scale Break") +
  coord_cartesian(ylim = c(25000, 100000)) + 
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin= unit(c(1, 1, -1, 1), "lines"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(), 
        axis.title = element_blank())

p1

p2 <- ggplot(my_data, aes(x = location, y = sort(value))) +
  geom_point(shape = 1) +
  scale_x_continuous(limits = c(0, 425)) +
  scale_y_continuous(breaks = seq(0, 20000, 5000)) +
  labs(x = "Location (ordered by items sold)", 
       y = "Items Sold") +
  coord_cartesian(ylim = c(0, 20000)) + 
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2

p3 <- arrangeGrob(p1, p2)

p3

ggsave(paste0(this_base, ".png"), p3, width = 5, height = 4)

## pedantic: position of y axis label
## note: my_data is simulated
