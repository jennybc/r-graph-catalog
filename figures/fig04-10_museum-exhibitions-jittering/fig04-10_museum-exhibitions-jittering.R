## NOTE: THE DATA USED WAS SIMULATED, WE DID NOT HAVE ACCESS TO THE
##       RAW/ORIGINAL DATA.

library(ggplot2)
library(reshape2)

this_base <- "fig04-10_museum-exhibitions-jittering"

# code to simulate data
# library(plyr)
# upper <- list("Dia de los Muertos" = 60, "From Bustles to Bikinis" = 38,
#               "Next Stop Westchester" = 78, "Families" = 82,
#               "Customers & Communities" = 40, "What is An Animal" = 40, 
#               "Silent Witness" = 21, "Kopje" = 23, "Darkened Waters" = 65, 
#               "Darkened Waters 2" = 39, "The Universe in Your Hands" = 42)
# set.seed(0)
# my_data <- llply(upper, function(x) {
#   y <- rlnorm(n = 41, sdlog = 0.5)
#   y <- y / max(y)
#   y <- c(y, runif(8))
#   y * x})
# my_data <- # not sure what's so special about Judith? whatever ...
#   c(list("Judith Leyster" = c(4, 7, 7, 9, 10, 10, 11, 11, 13, 14, 15, 15, 20,
#                               21, 22, 22, 23, 27, 27, 28, 28, 29, 31, 32, 33,
#                               33, 35, 38, 38, 39, 40, 40, 40, 40, 42, 42, 42,
#                               43, 45, 47, 48, 48, 49, 49, 55, 58, 66, 72, 73)),
#     my_data)
# my_data <- data.frame(my_data)
# write.table(my_data, paste0(this_base, ".tsv"), sep = "\t", row.names = FALSE)

my_data <- read.delim(paste0(this_base, ".tsv"))
my_data_long <-
  melt(my_data, id = NULL,
       variable.name = "exhibition", value.name = "visit_length")
levels(my_data_long$exhibition) <-
  gsub("\\.\\.\\.", ".&.", levels(my_data_long$exhibition))
levels(my_data_long$exhibition) <-
  gsub("\\.", " ", levels(my_data_long$exhibition))

set.seed(0)

p <- ggplot(my_data_long, aes(x = visit_length, y = exhibition)) +
  geom_point(shape = 1, position = position_jitter(w = 0.1, h = 0.1)) +
  scale_x_continuous(breaks = seq(0, 80, 20), limits = c(-1, 100)) +
  scale_y_discrete(limits = rev(levels(my_data_long$exhibition))) +
  labs(x = NULL, y = "Times") + 
  ggtitle("Fig 4.10 Museum Exhibitions: Jittering") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 6)

