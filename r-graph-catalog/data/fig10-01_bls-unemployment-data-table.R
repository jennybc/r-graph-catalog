library(ggplot2)
library(gridExtra)

this_base <- "fig10-01_bls-unemployment-data-table"

my_data <- data.frame(
  Year = c(1948:1962),
  Jan = c(3.4, 4.3, 6.5, 3.7, 3.2, 2.9, 4.9, 4.9, 
          4.0, 4.2, 5.8, 6.0, 5.2, 6.6, 5.8),
  Feb = c(3.8, 4.7, 6.4, 3.4, 3.1, 2.6, 5.2, 4.7, 
          3.9, 3.9, 6.4, 5.9, 4.8, 6.9, 5.5),
  Mar = c(4.0, 5.0, 6.3, 3.4, 2.9, 2.6, 5.7, 4.6, 
          4.2, 3.7, 6.7, 5.6, 5.4, 6.9, 5.6),
  Apr = c(3.9, 5.3, 5.8, 3.1, 2.9, 2.7, 5.9, 4.7,
          4.0, 3.9, 7.4, 5.2, 5.2, 7.0, 5.6),
  May = c(3.5, 6.1, 5.5, 3.0, 3.0, 2.5, 5.9, 4.3,
          4.3, 4.1, 7.4, 5.1, 5.1, 7.1, 5.5),
  Jun = c(3.6, 6.2, 5.4, 3.2, 3.0, 2.5, 5.6, 4.2, 
          4.3, 4.3, 7.3, 5.0, 5.4, 6.9, 5.5),
  Jul = c(3.6, 6.7, 5.0, 3.1, 3.2, 2.6, 5.8, 4.0,
          4.4, 4.2, 7.5, 5.1, 5.5, 7.0, 5.4),
  Aug = c(3.9, 6.8, 4.5, 3.1, 3.4, 2.7, 6.0, 4.2,
          4.1, 4.1, 7.4, 5.2, 5.6, 6.6, 5.7),
  Sep = c(3.8, 6.6, 4.4, 3.3, 3.1, 2.9, 6.1, 4.1, 
          3.9, 4.4, 7.1, 5.5, 5.5, 6.7, 5.6),
  Oct = c(3.7, 7.9, 4.2, 3.5, 3.0, 3.1, 5.7, 4.3, 
          3.9, 4.5, 6.7, 5.7, 6.1, 6.5, 5.4),
  Nov = c(3.8, 6.4, 4.2, 3.5, 2.8, 3.5, 5.3, 4.2,
          4.3, 5.1, 6.2, 5.8, 6.1, 6.1, 5.7),
  Dec = c(4.0, 6.6, 4.3, 3.1, 2.7, 4.5, 5.0, 4.2, 
          4.2, 5.2, 6.2, 5.3, 6.6, 6.0, 5.5))

p <- ggplot(my_data, aes(x = Year, y = Jan)) + 
  annotation_custom(tableGrob(my_data, show.rownames = FALSE)) +
  ggtitle("Fig 10.1 BLS Unemployment Data: Table") +
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
       p, width = 7, height = 6)
