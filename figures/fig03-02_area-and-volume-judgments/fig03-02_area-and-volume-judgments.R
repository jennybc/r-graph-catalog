library(ggplot2)

this_base <- "fig03-02_area-and-volume-judgments" 

my_data <- data.frame(
  val1 = c(0.75, 2, 3, 4, 5, 5, 6, 7, 8),
  val2 = c(4, 6, 6, 8, 6, 5, 1, 0.5, 9),
  area = c(5, 8, 0.25, 4, 9, 0.5, 6, 1, 12))

p <- ggplot(my_data, aes(x = val1, y = val2, size = area)) +
  geom_point(shape = 21, show_guide = FALSE) + 
  # map z to area and make larger circles
  scale_size_area(max_size = 25) +
  scale_x_continuous(breaks = seq(2, 8, 2), limit = c(0, 9), 
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 10, 2), limit = c(0, 10), 
                     expand = c(0, 0)) +
  ggtitle("Fig 3.2 Area and Volume Judgments") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.title = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

## note: my_data is estimated

