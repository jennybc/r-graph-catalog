library(ggplot2)
library(reshape2)
library(grid)

this_base <- "fig08-04_task-data-unified"

my_data <- data.frame(
  task = c("Connect a stereo", "Create a mixed tape", "Program radio stations", 
           "Record on one side of a tape", "Program the CD player", 
           "Set the clock", "Set the timer to record", 
           "Listen to a song on a CD", "Listen to a tape", 
           "Listen to the radio"),
  Revised = c(8.8, 9.6, 7.7, 5.8, 2.6, 2.3, 2.2, 2.1, 2.2, 1.0),
  Original = c(18.6, 15.9, 11.3, 9.7, 6.4, 4.0, 3.7, 3.8, 2.6, 0.9))

my_data_long <- melt(my_data, id.vars = "task", 
                  measure.vars = c("Revised", "Original"),
                  variable.name = "type", value.name = "time")

p <- ggplot(my_data_long, aes(x = time, y = reorder(task, time), group = type)) +
  geom_point(aes(shape = type)) +
  scale_shape_manual(values = c(3, 1)) +
  labs(x = "Time (minutes)", y = NULL) +
  ggtitle("Fig 8.4 Task Data Unified") +
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

