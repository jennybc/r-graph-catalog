library(ggplot2)

this_base <- "fig03-08_detection"

set.seed(0)

my_data <- data.frame(x = runif(30, 5, 25), y = runif(30, 5, 25))

p <- ggplot(my_data, aes(x = x, y = y)) + 
  geom_point() + 
  scale_x_continuous(breaks = seq(0, 20, 5), limits = c(0, 25), 
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 25, 5), limits = c(0, 25),
                     expand = c(0, 0)) +
  ggtitle("Fig 3.8 Detection") +
  theme_bw() +
  theme(panel.grid.major = element_line(colour = "black"),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

## note: my_data is simulated to replace original

