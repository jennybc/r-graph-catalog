library(ggplot2)
library(reshape2)

this_base <- "fig08-07_task-data-bar-chart"

my_data <- data.frame(
  task = c("Connect a stereo", "Create a mixed tape", "Program radio stations", 
           "Record on one side of a tape", "Program the CD player", 
           "Set the clock", "Set the timer to record", 
           "Listen to a song on a CD", "Listen to a tape", 
           "Listen to the radio"),
  revised = c(8.8, 9.6, 7.7, 5.8, 2.6, 2.3, 2.2, 2.1, 2.2, 1.0),
  original = c(18.6, 15.9, 11.3, 9.7, 6.4, 4.0, 3.7, 3.8, 2.6, 0.9))

my_data_long <- melt(my_data, id.vars = "task", 
                  measure.vars = c("revised", "original"),
                  variable.name = "type", value.name = "time")

p <- ggplot(my_data_long, aes(x = reorder(task, time), y = time, 
                           fill = type, width = 0.6)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_bar(stat = "identity", position = "dodge", 
           colour = "black", show_guide = FALSE) +
  scale_fill_manual(values = c("grey40", "grey60")) +
  scale_y_continuous(breaks = seq(0, 20, 5), limits = c(0, 20), 
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Time (minutes)") +
  ggtitle("Fig 8.7 Task Data: Bar Chart") +
  coord_flip() +
  theme_bw() +
  theme(panel.grid.major.x = element_line(colour = "grey60"),
        panel.grid.major.y = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold"),
        axis.ticks.y = element_blank(),
        axis.title = element_text(face = "bold"),
        legend.position = "top",
        legend.title = element_blank()) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 6)
