library(ggplot2)
library(reshape2)

this_base <- "fig05-12_iris-data-parallel-coordinate-plots"

my_data <- iris
my_data$row <- rownames(my_data) # group lines by row

my_data_long <- 
  melt(my_data, c("row", "Species"), 
       c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
       variable.name = "part",)

my_data_long$part <- 
  factor(my_data_long$part, 
         c("Petal.Length", "Petal.Width", "Sepal.Width", "Sepal.Length"))

my_data_long <- subset(my_data_long, my_data_long$Species != "versicolor")

p <- ggplot(my_data_long, aes(x = part, y = value, group = Species)) +
  geom_line(aes(group = row, linetype = Species), colour = "black",
            show_guide = FALSE) +
  scale_x_discrete(expand = c(0, 0.1)) +
  scale_y_continuous(breaks = c(0, 8), labels = c("Min.", "Max."),
                     limits = c(min(my_data_long$value), max(my_data_long$value))) +
  coord_flip() +
  ggtitle("Fig 5.12 Iris Data: Parallel Coordinate Plots") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "black"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold", vjust = 1),
        axis.title = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

## pedantic: my_data does not match plot in book
