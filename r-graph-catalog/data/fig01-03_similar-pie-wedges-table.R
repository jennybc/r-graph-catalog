library(ggplot2)
library(gridExtra)

this_base <- "fig01-03_similar-pie-wedges-table"

my_data <- data.frame(
  variable = c("A", "B","C", "D", "E", "Total"),
  value = c(23.0, 22.0, 19.5, 18.5, 17.0, 100.0))


p <- ggplot(my_data, aes(x = value, y = variable)) + 
  annotation_custom(tableGrob(my_data, show.rownames = FALSE, 
                              show.colnames = FALSE, show.box = TRUE)) +
  ggtitle("Fig 1.3 Similar Pie Wedges: Table") +
  theme_bw() +
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 2),
        axis.ticks = element_blank(), 
        axis.text = element_blank(),
        axis.title = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 4, height = 4)
