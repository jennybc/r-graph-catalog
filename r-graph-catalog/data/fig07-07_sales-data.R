library(ggplot2)

this_base <- "fig07-07_sales-data"

set.seed(0)

x <- c(rnorm(400, 10, 3), runif(20, min = 0, max = 100))

my_data <- data.frame(value = sample(x, 420))

p <- ggplot(my_data, aes(x = c(1:420), y = value)) +
  geom_point(shape = 1) +
  scale_y_continuous(breaks = seq(0, 100, 20)) +
  labs(x = "Location", y = "Items Sold (thousands)") +
  ggtitle("Fig 7.7 Sales Data") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 5)

## note: my_data is simulated to resemble original data
