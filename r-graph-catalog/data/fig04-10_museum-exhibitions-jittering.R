library(ggplot2)
library(reshape2)

this_base <- "fig04-10_museum-exhibitions-jittering"

# simulate data
#
# set.seed(0)
# 
# upper <- list(60, 38, 35, 47, 40, 25, 21, 23, 36, 24, 22)
# 
# my_data <- t(ldply(upper, function(x) {sample(0:x, 49, replace = TRUE)}))
# 
# my_data <- data.frame(
#   judith = c(4, 7, 7, 9, 10, 10, 11, 11, 13, 14, 15, 15, 20, 21, 22, 22, 23, 
#              27, 27, 28, 28, 29, 31, 32, 33, 33, 35, 38, 38, 39, 40, 40, 40, 
#              40, 42, 42, 42, 43, 45, 47, 48, 48, 49, 49, 55, 58, 66, 72, 73),
#   my_data)

my_data <- read.delim(paste0(this_base, ".tsv"), sep = "\t")

names(my_data) <- c("Judith Leyster", "Dia de los Muertos", 
                    "From Bustles to Bikinis", "Next Stop Westchester", 
                    "Families", "Customers & Communities", "What is An Animal", 
                    "Silent Witness", "Kopje", "Darkened Waters", 
                    "Darkened Waters 2", "The Universe in Your Hands")

my_data_long <- melt(my_data, id = NULL)

my_data_long$variable <- 
  factor(my_data_long$variable, 
         levels = 
           rev(c("Judith Leyster", "Dia de los Muertos", 
                 "From Bustles to Bikinis", "Next Stop Westchester", 
                 "Families", "Customers & Communities", "What is An Animal", 
                 "Silent Witness", "Kopje", "Darkened Waters", 
                 "Darkened Waters 2", "The Universe in Your Hands")))

set.seed(0)

p <- ggplot(my_data_long, aes(x = variable, y = value)) +
  geom_point(shape = 1, position = position_jitter(w = 0.1, h = 0.1)) + 
  scale_y_continuous(breaks = seq(0, 80, 20), limits = c(-1, 100)) +
  labs(x = NULL, y = "Times") + 
  coord_flip() +
  ggtitle("Fig 4.10 Museum Exhibitions: Jittering") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 6)

## note: data was simulated and outliers were inspired by the original 

