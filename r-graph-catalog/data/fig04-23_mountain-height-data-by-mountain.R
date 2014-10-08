library(ggplot2)

this_base <- "fig04-23_mountain-height-data-by-mountain"

my_data <- data.frame(
  cont = c("Asia", "S.America", "N.America", "Africa",
           "Antarctica", "Europe", "Austrailia"),
  height = c(29029, 22838, 20322, 19341, 16050, 16024, 7310),
  mountain = c("Everest", "Aconcagua", "McKinley", "Kilmanjaro",
               "Vinson", "Blanc", "Kosciuszko"),
  stringsAsFactors = FALSE)

p <- ggplot(my_data, aes(x = mountain, y = height, group = factor(1))) +
 geom_line() + geom_point() +
  scale_y_continuous(breaks = seq(0, 35000, 5000), limits = c(0, 35000), 
                     expand = c(0, 0)) +
  labs(x = "Continent", y = "Height (feet)") +
  ggtitle("Fig 4.23 Mountain Height Data by Mountain") +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey50"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_text(face = "bold"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 4)


