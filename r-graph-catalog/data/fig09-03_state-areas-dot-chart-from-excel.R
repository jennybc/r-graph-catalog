library(ggplot2)

this_base <- "fig09-03_state-areas-dot-chart-from-excel"

my_data <- data.frame(
  state_name = state.name,
  state_area = state.area,
  state_area_scaled = state.area / 1000)

p <- ggplot(my_data, aes(x = state_area_scaled, 
                         y = reorder(state_name, state_area_scaled))) +
  geom_point(shape = 18) + 
  scale_x_continuous(breaks = seq(0, 500, 100), limits = c(0, 600), 
                     expand = c(0, 0)) +
  labs(x = "Area (thousand square miles)") +
  ggtitle("Fig. 9.3 State Areas: Dot Chart from Excel") +
  theme_bw() + 
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey70"),
        plot.title = element_text(face = "bold", vjust = 1.5),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_text(size = rel(0.9)))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 6)

## pedantic: missing tick marks at top of plot

