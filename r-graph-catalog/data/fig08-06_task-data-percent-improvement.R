library(ggplot2)

this_base <- "fig08-06_task-data-percent-improvement"

my_data <- data.frame(
  task = c("Connect a stereo", "Create a mixed tape", "Program radio stations", 
           "Record on one side of a tape", "Program the CD player", 
           "Set the clock", "Set the timer to record", 
           "Listen to a song on a CD", "Listen to a tape", 
           "Listen to the radio"),
  Revised = c(8.8, 9.6, 7.7, 5.8, 2.6, 2.3, 2.2, 2.1, 2.2, 1.0),
  Original = c(18.6, 15.9, 11.3, 9.7, 6.4, 4.0, 3.7, 3.8, 2.6, 0.9))

my_data$improvement <- with(my_data, Original - Revised)
my_data$pct_improvement <- with(my_data, 100 * improvement/Original)

p <- ggplot(my_data,
            aes(x = pct_improvement, y = reorder(task, pct_improvement))) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 60, 20)) +
  labs(x = "Percent Improvement", y = NULL) +
  ggtitle("Fig 8.6 Task Data: Percent Improvement") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey60"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold"),
        axis.ticks.y = element_blank())

p

ggsave(paste0(this_base, ".png"),
       p, width = 6, height = 6)

