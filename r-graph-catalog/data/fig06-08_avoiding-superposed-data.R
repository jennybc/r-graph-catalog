library(ggplot2)
library(grid)

this_base <- "fig06-08_avoiding-superposed-data"

set.seed(100)

my_data <- data.frame(x = rnorm(100, mean = 15, sd = 10), 
                   y = c(rnorm(50, mean = 15, sd = 10), 
                         rnorm(50, mean = 25, sd = 10)))

my_data$grp <- c(rep("Group: A", 33), rep("Group: B", 33), rep("Group: C", 34))

p <- ggplot(my_data, aes(x = x, y = jitter(y, 2), group = grp)) +
  geom_point(aes(shape = grp), show_guide = FALSE) +
  facet_wrap(~ grp) +
  scale_shape_manual(values = c(65, 66, 67)) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 45),
                     expand = c(0, 0)) + 
  scale_x_continuous(breaks = seq(0, 40, 20), minor_breaks = c(10, 30),
                     #labels = c(0, "", 20, "", 40),
                     limits = c(0, 45), expand = c(0, 0)) +
  labs(x = "X", y = "Y") +
  ggtitle("Fig 6.8 Avoiding Superposed Data") +
  theme_bw() +
  theme(panel.grid.major = element_line(colour = "grey60"),
        panel.grid.minor = element_line(linetype = "dotted", colour = "grey60"),
        panel.margin = unit(0, "lines"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        strip.background = element_rect(fill = "white"))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 6)

## pedantic: x axis at top for middle facet
