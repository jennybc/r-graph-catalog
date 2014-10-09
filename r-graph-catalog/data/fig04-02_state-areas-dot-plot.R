library(ggplot2)

this_base <- "fig04-02_state-areas-dot-plot"

my_data <- data.frame(
  state_name = state.name,
  state_area = state.area,
  state_area_scaled = state.area / 1000)

p <- ggplot(my_data, aes(x = state_area_scaled, y = state_name)) +
  geom_point() +
  scale_x_continuous(breaks=seq(0, 500, 100), limits = c(0, 590)) +
  # reverse order of y axis
  scale_y_discrete(limits = rev(levels(my_data$state_name))) +
  labs(x = "Area (thousand square miles)", y = NULL) +
  ggtitle("Fig. 4.2 State Areas: Dot Plot") +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey70"),
        plot.title = element_text(face = "bold", vjust = 1.5),
        axis.ticks.y = element_blank(),
        axis.text.y = element_text(size = rel(0.9)))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 6)

