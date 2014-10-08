library(ggplot2)
library(gridExtra)

this_base <- "fig06-06_superposed-data-sets"

set.seed(100)

my_data <- data.frame(x = rnorm(100, mean = 15, sd = 10), 
                      y = c(rnorm(50, mean = 15, sd = 10), 
                            rnorm(50, mean = 25, sd = 10)))

my_data$country <- c(rep("England", 33), rep("France", 33), rep("Italy", 34))

p1 <- ggplot(my_data, aes(x = x, y = y, group = country)) +
  geom_point(aes(shape = country), show_guide = FALSE) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) + 
  scale_x_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p1


p2 <- ggplot(my_data, aes(x = x, y = y, group = country)) +
  geom_point(aes(shape = country), show_guide = FALSE) +
  scale_shape_manual(values = c(1, 19, 79)) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) + 
  scale_x_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2

# arrange plots together 
p3 <- arrangeGrob(p1, p2, nrow = 2,
                  main = textGrob("Fig 6.6 Superposed Data Sets", 
                                  just = "top", vjust = 0.75, 
                                  gp = gpar(lineheight = 1, 
                                            fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), p3, width = 4, height = 6)

## note: my_data is simulated to resemble the original


