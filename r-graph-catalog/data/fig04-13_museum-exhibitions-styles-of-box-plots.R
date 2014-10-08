library(ggplot2)
library(reshape2)

this_base <- "fig04-13_museum-exhibitions-styles-of-box-plots"

my_data <- read.delim(paste0(this_base, ".tsv"), sep = "\t")

my_data_long <- melt(my_data, id = NULL)

my_data_long$variable <- factor(my_data_long$variable, 
                  levels = c("Silent.Witness", "Kopje", "Darkened.Waters", 
                             "What.is.An.Animal", "Darkened.Waters.2",
                             "Customers...Communities", "From.Bustles.to.Bikinis", 
                             "Families", "Next.Stop.Westchester",
                             "Dia.de.los.Muertos", "Judith.Leyster", 
                             "The.Universe.in.Your.Hands"))

my_data_long <- subset(my_data_long, variable != "The.Universe.in.Your.Hands")

p <- ggplot(my_data_long, aes(x = variable, y = value)) +
  geom_boxplot(fill = "grey80") +
  stat_summary(fun.y = median, geom = "point", 
               shape = 18, size = 3, show_guide = FALSE) +
  scale_x_discrete(label = c("SW", "Kopj", "DW", "WIAA", "DW2", "C&C", "Bikini",
                             "Families", "Next", "DOD2", "Leyst")) +
  labs(x = NULL, y = "Time (minutes)") +
  ggtitle("Fig 4.13 Museum Exhibitions:\nStyles of Box Plots") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 6)


## note: data was simulated and outliers were inspired by the original
