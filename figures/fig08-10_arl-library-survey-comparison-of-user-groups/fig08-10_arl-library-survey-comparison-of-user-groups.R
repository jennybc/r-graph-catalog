library(ggplot2)
library(reshape2)
library(grid)

this_base <- "fig08-10_arl-library-survey-comparison-of-user-groups"

my_data <- read.delim(paste0(this_base, ".tsv"))

my_data_long <- 
  melt(my_data, c("Question", "Group"), variable.name = "type")

# set up helper cols for constructing interval
l_ind <- which(my_data_long$type %in% c("Minimum", "Desired"))
r_ind <- which(my_data_long$type %in% c("Minimum", "Desired"))

my_data_long[l_ind, "l_gap"] <- 0
my_data_long[r_ind, "r_gap"] <- 0

l_gap <- subset(my_data_long, type == "Perceived", value) - 
  subset(my_data_long, type == "Minimum", value)

r_gap <- subset(my_data_long, type == "Desired", value) - 
  subset(my_data_long, type == "Perceived", value)

my_data_long[which(my_data_long$type == "Perceived"), "r_gap"] <- r_gap
my_data_long[which(my_data_long$type == "Perceived"), "l_gap"] <- l_gap

my_data_long$Group <- 
  factor(my_data_long$Group, levels = c("Other", "Undergrad", "Graduate", 
                                        "Faculty"))

my_data_long$Question <- 
  factor(my_data_long$Question, 
          levels = c("Hours", "Delivery", "Print Collections", 
                    "Journals", "Interdisciplinary"))

p <- ggplot(my_data_long, aes(x = value, y = Group, shape = type)) +
  geom_point() + 
  geom_segment(aes(x = value - l_gap, xend = value + r_gap, 
                   y = Group, yend = Group)) +
  facet_wrap(~ Question, ncol = 1) +
  scale_shape_manual(values = c(124, 124, 4), breaks = "Perceived",
                     name = "Line Segments from Minimum to Desired ") +
  scale_x_continuous(breaks = c(5, 6, 7, 8), limits = c(4, 9)) + 
  labs(x = "Scores", y = NULL) +
  ggtitle("Fig 8.10 ARL Library Survey: Comparison\nof User Groups") +
  theme_bw() + 
  theme(panel.grid.major.y = element_line(colour = 'grey60'), 
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.margin = unit(0, "lines"),
        plot.title = element_text(size = rel(1.2), face = "bold"),
        axis.title = element_blank(),
        axis.ticks.y = element_blank(),
        strip.background = element_rect(fill = "grey80"),
        legend.position = "top",
        legend.key = element_blank(),
        legend.title = element_text(face = "plain"))

p

ggsave(paste0(this_base, ".png"), p, width = 5, height = 7)

## TO DO: the data prep feels unnecessarily convoluted; fix that