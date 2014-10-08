library(ggplot2)

this_base <- "fig04-21_used-car-price-line-graph"

my_data <- data.frame(
  mileage = seq(10, 85, 5),
  price = c(8200, 8200, 8150, 7900, 7600, 7400, 6800, 6500, 6000, 5800, 
            5400, 5350, 5050, 4950, 4975, 4700))

p <- ggplot(my_data, aes(x = mileage, y = price)) +
  geom_line() + geom_point() +
  scale_x_continuous(limits = c(0, 100), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(4000, 9000, 1000), limits = c(4000, 9000), 
                     expand = c(0, 0)) +
  labs(x = "Mileage (thousands)", y = "Trade-in Price (dollars)") +
  ggtitle(expression(atop(bold("Fig 4.21 Used Car Price: Line Graph"), 
                          atop(bold("2002 Mercury Sable LS 4-Door"))))) +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey50"),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size=rel(1.2), face="bold", vjust = 1),
        axis.title = element_text(face = "bold"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 4)

## note: my_data is estimated
