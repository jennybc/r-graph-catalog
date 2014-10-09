library(ggplot2)
library(grid)

this_base <- "fig04-12_description-of-box-plot"

set.seed(0)
my_data <- data.frame(value = c(rnorm(10, 4, 1), 8, 9, 1))

label_data <- data.frame(
  label = c("outside value", "lower quartile", "median",
            "upper quartile", "outside value",
            "lower adjacent value", "upper adjacent value"),
  yinter = c(fivenum(my_data$value), 2.5, 6.5))

p <- ggplot(my_data, aes(x = factor(1, levels = 1:2), y = value)) +
  geom_boxplot(outlier.shape = 1) +
  annotate("text", x = 2, y = label_data$yinter, label = label_data$label) +
  annotate("segment", x = 1.6, xend = 1.5, 
           y = label_data$yinter, yend = label_data$yinter,
           arrow = arrow(length = unit(0.1, "cm"), type = "closed")) +
  scale_x_discrete(drop = FALSE) + 
  scale_y_continuous(breaks = seq(0, 8, 2), limits = c(0, 10)) +
  labs(x = NULL, y = "Data") + 
  ggtitle("Fig 4.12 Description of a Boxplot") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## pedantic: lines for upper/lower adjacent values
## note: data is simulated to resemble original

