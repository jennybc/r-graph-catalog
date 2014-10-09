library(ggplot2)
library(reshape2) #melt()
library(grid) #unit()

this_base <- "fig03-06_position-along-identical-nonaligned-scales"

my_data <- data.frame(
  variable = c("A", "B", "C", "D", "E", "F", "G"),
  First = c(2.5, 6, 10, 12.5, 15, 17.5, 20),
  Second = c(2.5, 4, 6, 10, 12, 15, 18),
  Third = c(2.5, 3, 5.5, 8, 11, 17, 20))

my_data_long <- melt(my_data,
                     id.vars = "variable",
                     measure.vars = c("First", "Second", "Third"),
                     variable.name = "group")

p <- ggplot(my_data_long, aes(x = value, y = variable)) + 
  geom_point() +
  facet_wrap(~ group, scales = "free") +
  scale_x_continuous(breaks = c(5, 10, 15)) +
  ggtitle("Fig 3.6 Position along Identical,\nNonaligned Scales") +
  theme_bw() +
  theme(panel.margin = unit(2, "lines"),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.75),
          axis.title = element_blank(),
        strip.background = element_blank(),
        strip.text = element_text(vjust = 1)) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

## pedantic: missing tick marks at top of facets
