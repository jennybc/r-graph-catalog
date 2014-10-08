library(ggplot2)

this_base <- "fig05-16_djia-high-low-open-close-plots"

my_data <- read.delim(paste0(this_base, ".tsv"))

my_data$Date <- as.Date(my_data$Date, format = "%b %d, %Y")

y_labels <- c(9500, "", 9700, "", 9900, "", 10100, "", 10300, "", "")

p <- ggplot(my_data) +
  geom_segment(aes(x = Date, xend = Date, y = Low, yend = High)) +
  geom_point(aes(x = Date - 0.1, y = Open), shape = 45, size = 4) +
  geom_point(aes(x = Date + 0.1, y = Close), shape = 45, size = 4) +
  scale_y_continuous(breaks = seq(9500, 10500, 100), limits = c(9500, 10490), 
                     labels = y_labels, expand = c(0, 0)) +
  labs(x = "2003", y = "DJIA") +
  ggtitle("Fig 5.16 DJIA: High-Low-Open-Close-Plots") + 
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)
