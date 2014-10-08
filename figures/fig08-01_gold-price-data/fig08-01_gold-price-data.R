library(ggplot2)
library(reshape2)

this_base <- "fig08-01_gold-price-data"

my_data <- data.frame( 
  Year = c(1979, 1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 
           1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996),
  Average = c(306, 615, 460, 376, 424, 361, 317, 368, 447, 437, 381, 
              383.51, 362.11, 343.82, 359.77, 384, 383.79, 387.81),
  High = c(510, 850, 599, 475, 505, 402, 340, 440, 500, 480,
           415, 425, 405, 360, 415, 400, 400, 420),
  Low = c(215, 480, 390, 298, 380, 306, 280, 330, 390, 395, 360,
          350, 345, 330, 326, 370, 370, 366))

my_data_long <- melt(my_data, "Year", c("Average", "High", "Low"), "level")

my_data_long$level <- factor(my_data_long$level, c("High", "Average", "Low"))

year_label <- my_data$Year
year_label<- year_label[-seq(2, 18, 2)]

p <- ggplot(my_data_long, aes(x = Year, y = value, 
                           group = level, fill = level, width = 0.6)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_bar(stat = "identity", position = "dodge", colour = "black", 
           show_guide = FALSE) +
  scale_fill_manual(values = c("grey30", "grey70", "grey50")) +
  scale_x_continuous(breaks = seq(1979, 1996, 2), labels = year_label) +
  scale_y_continuous(breaks = seq(0, 900, 100), limits = c(0, 900),
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Gold Price (dollars)") +
  ggtitle("Fig 8.1 Gold Price Data") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey60"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"),
        legend.position = "top",
        legend.title = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

