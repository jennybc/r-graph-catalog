library(ggplot2)
library(scales)

this_base <- "fig06-10_stock-market-data-clarified"

my_data <- read.delim(paste0(this_base, ".tsv"),
                      colClasses = list(Time = "Date"))
my_data$stock <- factor(my_data$stock, c("GD", "MRK", "GE", "MSFT"))

p <- ggplot(my_data, aes(x = Time, y = Adj.Close)) + 
  geom_line(aes(group = stock)) +
  facet_wrap(~ stock, ncol = 1) +
  scale_x_date(breaks = "year", expand = c(0, 1), labels = date_format("%Y")) +
  scale_y_continuous(breaks = c(30, 60), limits = c(0, 65), expand = c(0, 0)) +
  labs(x = NULL, y = "Adjusted closing price") +
  ggtitle("Fig 6.10 Stock Market Data: Clarified") + 
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey50"),
        panel.grid.major.x = element_line(colour = "grey50"),
        panel.grid.minor.x = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        legend.position = "top",
        legend.title = element_blank(),
        legend.key = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 6)

## pedantic: missing Quarter labels for x axis
## note: my_data obtained from source doesnt match with book

