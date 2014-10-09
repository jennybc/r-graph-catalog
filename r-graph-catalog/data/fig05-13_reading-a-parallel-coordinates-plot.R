library(ggplot2)
library(reshape2)

this_base <- "fig05-13_reading-a-parallel-coordinates-plot"

my_data <- data.frame(x = c(2, 3, 1, 4), 
                      y = c(4, 1, 3, 3),
                      z = c(3, 4, 3.5, 2))

my_data$row <- rownames(my_data)

my_data_long <- melt(my_data, "row")

p <- ggplot(my_data_long, aes(x = variable, y = value)) +
  geom_line(aes(group = row, linetype = row), colour = "black",
            show_guide = FALSE) +
  scale_x_discrete(expand = c(0, 0.1)) +
  scale_y_continuous(breaks = c(1, 4), labels = c("Min.", "Max."),
                     limits = c(min(my_data_long$value), max(my_data_long$value))) +
  coord_flip() + 
  ggtitle("Fig 5.13 Reading a Parallel Coordinates Plot") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "black"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold", vjust = 1),
        axis.title = element_blank(),
        axis.ticks.y = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)
