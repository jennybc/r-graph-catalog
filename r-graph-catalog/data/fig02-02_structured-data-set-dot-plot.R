library(ggplot2)

this_base <- "fig02-02_structured-data-set-dot-plot"

my_data <- data.frame(
  variable = paste(rep("Item", 10), seq(1:10)),
  value = c(0.07, 0.12, 0.08, 0.13, 0.075, 
            0.125, 0.085, 0.135, 0.065, 0.115))

my_data$variable <- factor(my_data$variable, my_data$variable)

p <- ggplot(my_data, aes(x = value, y = variable)) +
  geom_point(size = 3) +
  scale_x_continuous(breaks = seq(0, 0.14, 0.02), limits = c(0, 0.14)) +
  ggtitle("Fig 2.2 Structured Data Set: Dot Plot") +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50", 
                                          linetype = "solid"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 8, height = 4)

## pedantic: missing tick marks at top of plot
