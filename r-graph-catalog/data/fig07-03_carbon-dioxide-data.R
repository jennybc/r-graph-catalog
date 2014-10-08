library(ggplot2)
library(gridExtra) #arrangeGrob

this_base <- "fig07-03_carbon-dioxide-data"

my_data <- data.frame(
  co2 = as.numeric(co2),
  date = seq(as.Date("1959-01-01"),  by = "month", length.out = 12*39))

my_data <- subset(my_data, date < as.Date("1991-01-01"))

p1 <- ggplot(my_data, aes(x = date, y = co2)) +
  stat_smooth(method = "loess", se = FALSE, colour = "black") +
  labs(x = NULL, y = "Carbon Dioxide (ppm)") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


p2 <- p1 + scale_y_continuous(breaks = seq(0, 300, 100), limits = c(0, 400))

p3 <- p3 <- arrangeGrob(p1, p2, nrow = 2,
                        main = textGrob("Fig 7.3 Carbon Dioxide Data", 
                                        just = "top", vjust = 0.75, 
                                        gp = gpar(fontsize = 17, 
                                                  lineheight = 1, 
                                                  fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 5, height = 6)

