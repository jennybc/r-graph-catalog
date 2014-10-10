library(ggplot2)
library(reshape2)
library(gridExtra)

this_base <- "fig08-03_task-data"

task <- c("Connect a Stereo", "Set the Clock",
          "Program Radio Stations", "Listen to the Radio", 
          "Listen to a Tape","Record on One Side of a Tape", 
          "Listen to a Song on a CD", "Program the CD Player", 
          "Create a Mixed Tape", "Set the Timer to Record")

my_data <- data.frame(
  task = factor(task, task),
  Original = c(18.6, 4.0, 11.3, 0.9, 2.6, 9.7, 3.8, 6.4, 15.9, 3.7),
  Revised = c(8.8, 2.3, 7.7, 1.0, 2.2, 5.8, 2.1, 2.6, 9.6, 2.2))

my_data_long <- melt(my_data, id.vars = "task", 
                     measure.vars = c("Original", "Revised"),
                     variable.name = "type", value.name = "time")

txt <- sprintf("%.1f", 
               round(as.vector(t(my_data[c("Original", "Revised")])), 2))

p1 <- ggplot(my_data_long, aes(x = type, y = time)) +
  geom_bar(stat = "identity", fill = "black") +
  geom_text(aes(label = txt, vjust = -0.25)) +
  facet_wrap( ~ task, ncol = 3, scales = "free") +
  scale_y_continuous(breaks = seq(0, 20, 4), limits = c(0, 24), 
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Time in Minutes") +
  ggtitle(expression(
    atop(bold("Fig 8.3 Task Data"), 
         atop(bold("Average Time Spent on Stero Tasks: Original vs Revision"), 
              "")))) +
  theme_classic() +
  theme(plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1),
        strip.background = element_blank(),
        strip.text = element_text(face = "bold"),
        axis.ticks.x = element_blank())
p1

footnote <- 
  paste("Note. Values represent participants' mean time per task.\n",
        "17 participants (three English-only speakers, five French",
        "bilinguals, four German bilinguals, five Spanish bilinguals)\n",
        "completed 10 tasks using the original instruction guide.\n", 
        "12 participants (three English-only speakers, three French ",
        "bilinguals, three German bilinguals, three Spanish \nbilinguals)",
        "completed 10 tasks using the revised instruction guide.\n\n")

p <- arrangeGrob(p1, 
                 sub = textGrob(paste(footnote, collapse = "\n"), 
                                x = 0, hjust = -0.1, vjust = 0.75, 
                                gp = gpar(fontface = "italic", fontsize = 10)))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 8)

## pedantic: extra indentation in footnote, 
## todo: missing superscripts in footnote
