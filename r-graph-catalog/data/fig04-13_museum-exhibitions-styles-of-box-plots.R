## NOTE: THE DATA USED WAS SIMULATED, WE DID NOT HAVE ACCESS TO THE
##       RAW/ORIGINAL DATA.

library(ggplot2)
library(reshape2)
library(plyr)

this_base <- "fig04-13_museum-exhibitions-styles-of-box-plots"

my_data <- read.delim(paste0(this_base, ".tsv"), sep = "\t")
my_data_long <-
  melt(my_data, id = NULL,
       variable.name = "exhibition", value.name = "visit_length")
my_data_long <-
  subset(my_data_long, !(exhibition %in% c("The.Universe.in.Your.Hands",
                                           "Dia.de.los.Muertos")))
my_data_long$exhibition <-
  revalue(my_data_long$exhibition,
          c("Judith.Leyster" = "Leyst", "From.Bustles.to.Bikinis" = "Bikini",
            "Next.Stop.Westchester" = "Next", "Customers...Communities" = "C&C",
            "What.is.An.Animal" = "WIAA", "Silent.Witness" = "SW",
            "Kopje" = "Kopj", "Darkened.Waters" = "DW",
            "Darkened.Waters.2" = "DW2"))

p <- ggplot(my_data_long, aes(x = reorder(exhibition, visit_length),
                              y = visit_length)) +
  geom_boxplot(fill = "grey80") +
  stat_summary(fun.y = median, geom = "point", 
               shape = 18, size = 3, show_guide = FALSE) +
  labs(x = NULL, y = "Time (minutes)") +
  ggtitle("Fig 4.13 Museum Exhibitions:\nStyles of Box Plots") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 6)

## note: data was simulated so even the order of the boxes differs from orig

