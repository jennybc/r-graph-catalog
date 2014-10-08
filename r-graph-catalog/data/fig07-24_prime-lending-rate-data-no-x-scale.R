library(ggplot2)
library(scales)

this_base <- "fig07-24_prime-lending-rate-data-no-x-scale"

my_data <- read.delim(paste0(this_base, ".tsv"))

my_data$date_axis <- seq(as.Date("1993-01-01"), as.Date("2003-12-01"), by="month")

p <- ggplot(my_data, aes(x = date_axis, y = Rate)) +
  geom_area(position = "stack", fill = "grey60") +
  scale_x_date(expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 0.1, 0.01), limits = c(0, 0.1),
                     expand = c(0, 0), labels = paste0(c(0:10), ".00%")) +
  labs(x = "1993 - 2003", y = NULL) +
  ggtitle("Fig 7.24 Prime Leading Rate Data: \nNo X Scale") +
  theme_classic() +
  theme(plot.title = element_text(size = rel(1.1), face = "bold", vjust = 2),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 4)

## note: my_data is estimated

