library(ggplot2)

this_base <- "fig03-04_length-judgments" 

my_data <- data.frame(ylow = c(4.2, 1.5, 2.5, 5, 3), 
                      yhigh = c(6.3, 3.7, 4.8, 7.4, 5.5))

p <- ggplot(my_data, aes(x = c(0, 6), y = range(c(ylow, yhigh)))) + 
  geom_segment(aes(x = 1:5, y = ylow, xend = 1:5, yend = yhigh)) +
  scale_x_continuous(breaks = seq(0, 6, 1), limit = c(0, 6)) +
  scale_y_continuous(limit = c(0,8)) +
  ggtitle("Fig 3.4 Length Judgments") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 4)


