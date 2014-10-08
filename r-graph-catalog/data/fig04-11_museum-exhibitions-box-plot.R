library(ggplot2)
library(reshape2)

this_base <- "fig04-11_museum-exhibitions-box-plot"

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

p <- ggplot(my_data_long, aes(x = variable, y = value)) +
  geom_boxplot(outlier.shape = 1) + 
  scale_y_continuous(breaks = seq(0, 80, 20), limits = c(0, 90)) +
  labs(x = NULL, y = "Time (minutes)") + 
  coord_flip() +
  ggtitle("Fig 4.11 Museum Exhibitions: Box Plot") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 5)

## note: data was simulated and outliers were inspired by the original

