library(ggplot2)
library(gridExtra)

this_base <- "fig06-04_data-that-are-difficult-to-see"

set.seed(0)

my_data <- data.frame(x = runif(30, 5, 25), y = runif(30, 5, 25))

p1 <- ggplot(my_data, aes(x = x, y = y)) + 
  geom_point(size = 1) + 
  scale_x_continuous(breaks = seq(0, 20, 5), limits = c(0, 25), 
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 25, 5), limits = c(0, 25),
                     expand = c(0, 0)) +
  theme_bw() +
  theme(panel.grid.major = element_line(colour = "black"),
        panel.grid.minor = element_blank())

p2 <- ggplot(my_data, aes(x = x, y = y)) + 
  geom_point(shape = 1, size = 2) + 
  scale_x_continuous(breaks = seq(0, 20, 5), limits = c(0, 25), 
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 25, 5), limits = c(0, 25),
                     expand = c(0, 0)) +
  theme_bw() +
  theme(panel.grid.major = element_line(colour = "black"),
        panel.grid.minor = element_blank())


p3 <- arrangeGrob(p1, p2, nrow = 2, 
                  main = textGrob(
                    "Fig 6.4 Data That Are Difficult to See",
                    just = "top", vjust = 0.75, gp = gpar(fontface = "bold")))

p3


ggsave(paste0(this_base, ".png"), 
       p3, width = 5, height = 6)

## note: my_data is estimated

