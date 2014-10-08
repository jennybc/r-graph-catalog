library(ggplot2)

this_base <- "fig02-01_structured-data-set"

my_data <- data.frame(
  variable = paste(rep("Item", 10), seq(1:10)),
  value = c(0.07, 0.12, 0.08, 0.13, 0.075, 
            0.125, 0.085, 0.135, 0.065, 0.115))

# reorder levels
my_data$variable <- factor(my_data$variable, 
                        levels = c(rev(paste(rep("Item", 10), seq(1:10)))))

angle_breaks <- c(10, 20, 30, 43, 53, 60, 70, 83, 93, 103) - 5

p <- ggplot(my_data, aes(x = factor(1), fill = variable, weight = value*100)) +
  geom_bar(width = 1, show_guide = FALSE, colour = 'black') +
  geom_text(aes(x = 1.75, y = angle_breaks, label = rev(variable))) +
  coord_polar(theta = "y", start = pi/2) +
  # determine angle at which to place labels
  scale_fill_manual("variable" , values = rep('white', 10)) +
  ggtitle("Fig 2.1 Structured Data Set") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())

p

ggsave(paste0(this_base, ".png"),
       p, width = 6, height = 5)

