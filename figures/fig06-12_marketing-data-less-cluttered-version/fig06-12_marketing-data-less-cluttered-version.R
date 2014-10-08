library(ggplot2)

this_base <- "fig06-12_marketing-data-less-cluttered-version"

set.seed(3)

my_data <- data.frame(state = state.abb,
                      market_share = runif(50, 0, 50),
                      market_size = rexp(50, 0.13))

p <- ggplot(my_data, aes(x = market_size, y = market_share)) +
  geom_text(aes(label = state), size = 3) +
  geom_hline(yintercept = median(my_data$market_share)) +
  geom_vline(xintercept = median(my_data$market_size)) +
  labs(x = "Market Size (millions)", y = "Market Share (%)") +
  ggtitle("Fig 6.12 Marketing Data: Less\nCluttered Version") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## note: my_data was simulated to resemble original data

