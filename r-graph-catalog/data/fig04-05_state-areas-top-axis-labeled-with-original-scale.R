library(ggplot2)

this_base <- "fig04-05_state-areas-top-axis-labeled-with-original-scale"

my_data <- data.frame(
  state_name = state.name,
  state_area = state.area,
  state_area_scaled = state.area / 1000)

p <- ggplot(my_data, aes(x = log2(state_area_scaled),
                      y = reorder(state_name, state_area_scaled))) +
  geom_point() + 
  scale_x_continuous(breaks = seq(0,8,2), limits = c(0, 9.25)) +
  labs(x = "Log Area (base = 2)", y = NULL) +
  ggtitle("Fig. 4.5 State Areas: Top Axis Labeled \nwith Original Scale") +
  theme_bw() + 
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey70"),
        plot.title = element_text(face = "bold", vjust = 1.5),
        axis.ticks.y = element_blank(),
        axis.text.y = element_text(size = rel(0.9)))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 6)

## TODO: missing original scale axis at top of plot


