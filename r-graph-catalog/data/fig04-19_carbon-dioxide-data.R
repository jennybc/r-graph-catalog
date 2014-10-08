library(ggplot2)
library(scales) # scale_x_date()

this_base <- "fig04-19_carbon-dioxide-data"

my_data <- data.frame(
  co2 = as.numeric(co2),
  date = seq(as.Date("1959-01-01"),  by = "month", length.out = 12*39))

my_data <- subset(my_data, date < as.Date("1991-01-01"))

datebreaks <- seq(as.Date("1960-01-01"), as.Date("1997-12-01"), by = "5 year")

p <- ggplot(my_data, aes(x = date, y = co2)) +
  geom_line() +
  stat_smooth(method = "loess", se = FALSE, colour = "black") +
  scale_x_date(breaks = datebreaks, labels = date_format("%Y"),
               limits = c(as.Date("1960-01-01"), as.Date("1990-12-01"))) +
  scale_y_continuous(breaks = seq(320, 350, 10), limits = c(310, 360),
                     expand = c(0, 0)) + 
  labs(y = "Carbon Dioxide (ppm)") +
  ggtitle("Fig. 4.19 Carbon Dioxide Data") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title.x = element_blank()) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 6)

## pedantic: missing tickmarks at top and right of graph

