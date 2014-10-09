library(ggplot2)
library(gridExtra)

this_base <- "fig03-03_color-hue-saturation-and-density"

set.seed(100)

my_data <- data.frame(x = rnorm(100, mean = 20, sd = 10),
                      y = c(rnorm(50, mean = 20, sd = 10), 
                            rnorm(50, mean = 25, sd = 10)),
                      country = rep(c("England", "France", "Italy"), c(33, 33, 34)))

p1 <- ggplot(my_data, aes(x = x, y = y, group = country)) +
  geom_point(aes(shape = country), show_guide = FALSE) +
  scale_x_continuous(breaks = seq(0, 40, 10), limits = c(-5, 47)) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(-5, 47)) + 
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p1

p2 <- ggplot(my_data, aes(x = x, y = y, group = country)) +
  geom_point(aes(shape = country, colour = country), show_guide = FALSE) +
  scale_colour_manual(values = c("grey40", "black", "grey70")) +
  scale_x_continuous(breaks = seq(0, 40, 10), limits = c(-5, 47)) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(-5, 47)) + 
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2

# arrange plots together 
p3 <- arrangeGrob(p1, p2, nrow = 2,
                  main = textGrob("Fig 3.3 Color, Hue, Saturation, and Density", 
                                  just = "top", vjust = 0.75, 
                                  gp = gpar(fontsize = 14, lineheight = 1, 
                                            fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), p3, width = 4, height = 6)

## note: my_data is simulated replace original

