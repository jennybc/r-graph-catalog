library(ggplot2)
library(gridExtra)
library(dplyr)

this_base <- "fig04-01_state-areas-strip-plot"

my_data <- data.frame(state.area.scaled = state.area / 1000)

summ_stats <-
  with(my_data,
       data.frame(stat = c("Mean", "Median", "Quartile", "Quartile"),
                  val = c(mean(state.area.scaled), median(state.area.scaled),
                          quantile(state.area.scaled, probs = c(0.25, 0.75)))))

p1 <- ggplot(my_data, aes(x = state.area.scaled, y = factor(1))) + 
  geom_point(shape = 1) + 
  scale_x_continuous(breaks = seq(0, 500, 100), limits = c(0, 600)) +
  labs(x = "Area (thousand square miles)", y = NULL) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks.y = element_blank())

p2 <- p1 +
  geom_vline(data = summ_stats,
             aes(xintercept = val, linetype = stat), show_guide = TRUE) +
  theme(legend.position = "top",
        legend.justification = c(1, 0)
        legend.title = element_blank()) 

p3 <- arrangeGrob(p1, p2, nrow = 2, heights = c(0.45, 0.55), 
                  main = textGrob("Fig 4.1 State Areas: Strip Plot", 
                                  just = "top", gp = gpar(fontface = "bold")))
p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

## TODO: fix legend so that lines are displayed horizontally in legend key
