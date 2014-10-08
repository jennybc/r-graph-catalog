library(ggplot2)

this_base <- "fig06-11_marketing-data"

set.seed(3)

my_data <- data.frame(state = state.abb,
                      market_share = runif(50, 0, 50),
                      market_size = rexp(50, 0.13))

x_labels <- seq(0, 40, 5) * 1000000
y_labels <- seq(0, 50, 5)

p <- ggplot(my_data, aes(x = market_size, y = market_share)) +
  geom_text(aes(label = state), hjust = -1, vjust = -1, size = 3) +
  geom_point(shape = 18, size = 3) + 
  geom_hline(yintercept = median(my_data$market_share)) +
  geom_vline(xintercept = median(my_data$market_size)) +
  annotate("text", label = x_labels, x = seq(0, 40, 5), y = 19, size = 3) +
  annotate("text", label = y_labels, x = median(my_data$market_size) - 1, 
           y = seq(0, 50, 5), size = 3) +
  scale_x_continuous(breaks = seq(0, 40, 5), limits = c(0, 41)) +
  labs(x = "Market Size (Population)", y = "Market Share (%)") +
  ggtitle("Fig 6.11 Marketing Data") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.title = element_text(face = "bold"),
        axis.text = element_blank(),
        axis.ticks = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## note: my_data was simulated to resemble original data

