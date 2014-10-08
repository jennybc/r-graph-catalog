library(ggplot2)

this_base <- "fig07-09_sales-data-ordered-data-with-logarithmic-scale"

set.seed(0)

x <- c(rnorm(400, 10, 3), runif(20, min = 0, max = 100))

my_data <- data.frame(value = sample(x, 420), location = c(1:420))

p <- ggplot(my_data, aes(x = location, y = sort(log10(value)))) +
  geom_point(shape = 1) +
  annotate("segment", x = quantile(my_data$location, 0.5), 
           xend = quantile(my_data$location, 0.5), 
           y = 0, yend = quantile(log10(my_data$value), 0.5)) +
  annotate("segment", x = 0, xend = quantile(my_data$location, 0.5), 
           y = quantile(log10(my_data$value), 0.5), 
           yend = quantile(log10(my_data$value), 0.5)) +
  scale_y_continuous(breaks = seq(1, 5, 1)) +
  labs(x = "Location (ordered by items sold)", 
       y = expression(paste(Log["10"], "(Items Sold)"))) +
  ggtitle("Fig 7.9 Sales Data: Ordered Data\nwith Logarithmic Scale") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## note: data is simulated 

