library(ggplot2)
library(gridExtra)

this_base <- "fig07-06_logarithmic-scales-for-percent-change"

my_data <- data.frame(
  day = 1:11,
  dollars = 2^(0:10))

p1 <- ggplot(my_data, aes(x = day, y = dollars)) +
  geom_point(shape = 21, fill = "white") +
  scale_x_continuous(breaks = seq(2, 10, 2), limits = c(0, 11.5)) +
  scale_y_continuous(breaks = seq(0, 1000, 200), limits = c(0, 1050)) +
  labs(x = "Day", y = "Dollars") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
p1

p2 <- ggplot(my_data, aes(x = day, y = log10(dollars))) +
  geom_point(shape = 21, fill = "white") +
  scale_x_continuous(breaks = seq(2, 10, 2), limits = c(1, 11.5)) +
  scale_y_continuous(breaks = seq(0, 3, 0.5), limits = c(0, 3.1)) +
  labs(x = "Day", y = expression(Log[10](Dollars))) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
p2

# arrange plots together 
p3 <- arrangeGrob(
  p1, p2, nrow = 2,
  main = textGrob("Fig 7.6 Logarithmic Scales for\nPercent Change", 
                  just = "top", vjust = 0.75, gp=gpar(fontsize = 14, 
                                                      lineheight = 1, 
                                                      fontface = "bold")))

p3

# must pass in p3 since arrangeGrob doesnt return ggplot object
ggsave(paste0(this_base, ".png"), 
       p3, width = 4, height = 6)

## pedantic: missing secondary y axis
