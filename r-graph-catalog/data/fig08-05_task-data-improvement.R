library(ggplot2)
library(grid)

this_base <- "fig08-05_task-data-improvement"

my_data <- data.frame(
  task = c("Connect a stereo", "Create a mixed tape", "Program radio stations", 
           "Record on one side of a tape", "Program the CD player", 
           "Set the clock", "Set the timer to record", 
           "Listen to a song on a CD", "Listen to a tape", 
           "Listen to the radio"),
  revised = c(8.8, 9.6, 7.7, 5.8, 2.6, 2.3, 2.2, 2.1, 2.2, 1.0),
  original = c(18.6, 15.9, 11.3, 9.7, 6.4, 4.0, 3.7, 3.8, 2.6, 0.9))

my_data$improvement = transform(my_data, improvement = original - revised)$improvement

p <- ggplot(my_data, aes(x = improvement, y = reorder(task, improvement))) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 10, 2)) +
  labs(x = "Time (minutes)", y = NULL) +
  ggtitle("Fig 8.5 Task Data: Improvement") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey60"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold"),
        axis.ticks.y = element_blank(),
        legend.position = "top",
        legend.title = element_blank(),
        legend.key = element_blank(),
        legend.key.width = unit(3, "lines"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 6)
