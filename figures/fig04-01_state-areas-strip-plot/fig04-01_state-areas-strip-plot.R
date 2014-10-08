library(ggplot2)
library(gridExtra)

this_base <- "fig04-01_state-areas-strip-plot"

my_data <- data.frame(state.area / 1000)
names(my_data) <- "state.area.scaled"

p1 <- ggplot(my_data, aes(x = state.area.scaled, y = factor(1))) + 
  geom_point(shape = 1) + 
  scale_x_continuous(breaks = seq(0, 500, 100), limits = c(0, 600)) +
  labs(x = "Area (thousand square miles)", y = NULL) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank())

df <- with(my_data, {
  mu <- mean(state.area.scaled)
  med <- median(state.area.scaled)
  q1 <- quantile(state.area.scaled, probs = 0.25, names = FALSE)
  q2 <- quantile(state.area.scaled, probs = 0.75, names = FALSE)
  df <- data.frame(stat = c("Mean", "Median", "Quartile", "Quartile"), 
                   val = c(mu, med, q1, q2))
  df
})

p2 <- ggplot(my_data, aes(x = state.area.scaled, y = factor(1)), linetype = "line") + 
  geom_point(shape = 1) + 
  scale_x_continuous(breaks = seq(0,500, 100), limits = c(0, 600)) +
  labs(x = "Area (thousand square miles)") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) 

p2 <- p2 + geom_vline(data = df, aes(xintercept = val, linetype = stat), 
                      show_guide = TRUE)


p3 <- arrangeGrob(p1, p2, nrow = 2, heights = c(0.45, 0.55), 
                  main = textGrob("Fig 4.1 State Areas: Strip Plot", 
                                  just = "top", gp = gpar(fontface = "bold")))
p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

## TODO: fix legend so that lines are displayed horizontally in legend key
