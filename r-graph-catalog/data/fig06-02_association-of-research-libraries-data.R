library(ggplot2)

this_base <- "fig06-02_association-of-research-libraries-data"

my_data <- data.frame(
  discipline = c("Agriculture / Environmental Studies", "Architecture", 
                 "Business", "Communications / Journalism", "Education",
                 "Engineering / Computer Science", "Health Sciences",
                 "Humanities", "Law", "Performing & Fine Arts",
                 "Science / Math", "Social Sciences / Psychology",
                 "General Studies", "Undecided", "Other"),
  respondents = c(1142, 335, 2206, 749, 1984, 3233, 2198, 
                  2979, 521, 906, 3221, 3316, 178, 400, 2525),
  percent = c(4.41, 1.29, 8.52, 2.89, 7.66, 12.49, 8.49,
                 11.51, 2.01, 3.50, 12.44, 12.81, 0.69, 1.54, 9.75))


my_data$discipline <- factor(my_data$discipline, 
                          levels = rev(levels(my_data$discipline)))

p <- ggplot(my_data, 
            aes(x = discipline, y = percent, group = 1, label = percent)) +
  geom_point(shape = 15, size = 3) + 
  geom_line(aes(x = as.character(discipline))) + 
  geom_text(hjust = -0.1, size = 4) +
  scale_y_continuous(breaks = seq(0, 14, 2), limits = c(0, 14), 
                     expand = c(0, 0)) +
  labs(x = "Discipline", y = "Percentage of Respondents") +
  coord_flip() +
  ggtitle("Fig 6.2 Association of Research \n Libraries Data") +
  theme_bw() + 
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_line(colour = 'black'),
        plot.title = element_text(size = rel(2), vjust = 3, face = "bold"),
        axis.title = element_text(face = 'bold'),
        axis.ticks = element_blank()) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 8, height = 9)


