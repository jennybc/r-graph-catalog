library(ggplot2)

this_base <- "fig07-08_sales-data-logarithmic-scale"

set.seed(0)

x <- c(rnorm(400, 10, 3), runif(20, min = 0, max = 100))

my_data <- data.frame(value = sample(x, 420))

p <- ggplot(my_data, aes(x = c(1:420), y = log10(value))) +
  geom_point(shape = 1) +
  scale_y_continuous(breaks = seq(1, 5, 1)) +
  labs(x = "Location", y = expression(paste(Log["10"], "(Items Sold)"))) +
  ggtitle("Fig 7.8 Sales Data: Logarithmic Scale") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 5)

## note: my_data is simulated

## TO DO: log the y axis properly, i.e. not just logging the data

