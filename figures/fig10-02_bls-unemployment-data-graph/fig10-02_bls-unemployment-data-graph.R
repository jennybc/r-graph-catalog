library(ggplot2)
library(scales)
library(reshape2)

this_base <- "fig10-02_bls-unemployment-data-graph"

my_data <- read.delim(paste0(this_base, ".tsv"))

# format my_data to long format
my_data_long <-
  melt(my_data, "Year", variable.name = "month", value.name = "rate")
my_data_long <- 
  transform(my_data_long, 
            dat = as.Date(paste(Year, month, "01", sep = "/"), "%Y/%b/%d"))
my_data_long <-
  my_data_long[order(as.Date(my_data_long$dat, format = "%Y/%m/%d")), ]

p <- ggplot(my_data_long, aes(x = dat, y = rate)) + 
  geom_line() +
  scale_x_date(labels = date_format("%b %Y")) +
  labs(x = "Time (months)", y = "Unemployment Rate") +
  ggtitle("Fig 10.2 BLS Unemployment Data: Graph") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

## TO DO: some of the date stuff above looks overly fiddly to me