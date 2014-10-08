library(ggplot2)

this_base <- "fig08-02_gold-price-data-high-low-chart"

my_data <- data.frame( 
  Year = c(1979, 1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 
           1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996),
  Average = c(306, 615, 460, 376, 424, 361, 317, 368, 447, 437, 381, 
              383.51, 362.11, 343.82, 359.77, 384, 383.79, 387.81),
  High = c(510, 850, 599, 475, 505, 402, 340, 440, 500, 480,
           415, 425, 405, 360, 415, 400, 400, 420),
  Low = c(215, 480, 390, 298, 380, 306, 280, 330, 390, 395, 360,
          350, 345, 330, 326, 370, 370, 366))

p <- ggplot(my_data, aes(x = Year, y = Average)) +
  geom_point(shape = 95, size = 4) + 
  geom_segment(aes(x = c(1979:1996) - 0.15, xend = c(1979:1996) - 0.15,
                   y = Low, yend = High), my_data = my_data, hjust = 4) +
  scale_x_continuous(breaks = seq(1975, 1995, 5), limits = c(1975, 1997),
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(100, 900, 100), limits = c(100, 950),
                     expand = c(0, 0),
                     labels = c(100, "", 300, "", 500, "", 700, "", 900)) +
  labs(x = "Year", y = "Gold Price (dollars)") + 
  ggtitle("Fig 8.2 Gold Price Data: High-Low Chart") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 7, height = 5)
