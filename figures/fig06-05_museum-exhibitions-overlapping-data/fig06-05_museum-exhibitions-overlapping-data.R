## NOTE: THE DATA USED WAS SIMULATED, WE DID NOT HAVE ACCESS TO THE
##       RAW/ORIGINAL DATA.

library(ggplot2)
library(reshape2)

this_base <- "fig06-05_museum-exhibitions-overlapping-data"

my_data <- read.delim(paste0(this_base, ".tsv"))
my_data_long <-
  melt(my_data, id = NULL,
       variable.name = "exhibition", value.name = "visit_length")
levels(my_data_long$exhibition) <-
  gsub("\\.\\.\\.", ".&.", levels(my_data_long$exhibition))
levels(my_data_long$exhibition) <-
  gsub("\\.", " ", levels(my_data_long$exhibition))

p <- ggplot(my_data_long, aes(x = exhibition, y = visit_length)) +
  geom_point(shape = 1) +
  scale_x_discrete(limits = rev(levels(my_data_long$exhibition))) +
  scale_y_continuous(breaks = seq(0, 80, 20), limits = c(-1, 100)) +
  labs(x = NULL, y = "Times") + 
  coord_flip() +
  ggtitle("Fig 6.5 Museum Exhibitions: Overlapping Data") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 6)

