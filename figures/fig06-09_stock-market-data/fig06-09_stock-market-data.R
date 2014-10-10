library(ggplot2)
library(scales)

this_base <- "fig06-09_stock-market-data"

my_data <- read.delim(paste0(this_base, ".tsv"),
                      colClasses = list(Time = "Date"))
my_data$stock <- factor(my_data$stock, c("MRK", "MSFT", "GD", "GE"))

p <- ggplot(my_data,
            aes(x = Time, y = Adj.Close, group = stock)) + 
  geom_line() +
  scale_x_date(breaks = "year", expand = c(0, 1),
               labels = date_format("%m/%d/%Y")) +
  scale_y_continuous(limits = c(0, 60), expand = c(0, 0)) +
  labs(x = NULL, y = "Adjusted closing price") +
  ggtitle("Fig 6.9 Stock Market Data") + 
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey50"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold"),
        legend.position = "top",
        legend.title = element_blank(),
        legend.key = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 9, height = 4)

## note: my_data obtained from source doesnt not match with book

