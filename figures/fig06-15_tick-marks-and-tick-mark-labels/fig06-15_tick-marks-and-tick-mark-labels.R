library(ggplot2)

this_base <- "fig06-15_tick-marks-and-tick-mark-labels"

my_data <- data.frame(
  x = c(88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99), 
  y = c(-21, -14, -10, -4, 5, 6, -3, -7, 6, 20, 38, 36))

p <- ggplot(my_data, aes(x = x, y = y)) + 
  geom_bar(stat = "identity", position = "identity", aes(width = 1), 
           fill = "grey60") + 
  geom_hline(aes(yintercept = 0)) +
  scale_x_continuous(breaks = seq(88, 99, 1), limits = c(87.5, 99.5)) +
  scale_y_continuous(breaks = seq(-30, 40, 10), limits = c(-30, 40),
                     expand = c(0, 0)) +
  coord_cartesian(xlim = c(87.5,99.5), ylim = NULL) +
  ggtitle("Fig 6.15 Tick Marks and Tick Mark Labels") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), vjust = 1.5, face = "bold"),
        axis.ticks = element_blank(),
        axis.text = element_text(size = 25),
        axis.title = element_blank()) 

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## pedantic: missing black outline for bars


