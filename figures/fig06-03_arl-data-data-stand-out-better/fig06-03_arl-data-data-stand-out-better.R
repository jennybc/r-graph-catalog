library(ggplot2)

this_base <- "fig06-03_arl-data-data-stand-out-better"

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

p <- ggplot(my_data, aes(x = reorder(discipline, percent), y = percent, 
                      group = 1, label = percent)) +
  geom_point() + 
  coord_flip() +
  scale_y_continuous(breaks = seq(2, 12, 2), limits = c(0, 14), 
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Percentage of Respondents of ARL Survey") +
  ggtitle("Fig 6.3 ARL Data: Data Stand Out Better") + 
theme_bw() + 
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = 'black'),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), vjust = 3, face = "bold"),
        axis.title = element_text(face = 'bold'))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 8, height = 9)

