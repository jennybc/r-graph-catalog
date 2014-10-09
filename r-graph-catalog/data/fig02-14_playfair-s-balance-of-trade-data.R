library(ggplot2)
library(reshape2) # melt()
library(grid) # arrow()

this_base <- "fig02-14_playfair-s-balance-of-trade-data"

my_data_wide <- read.delim(paste0(this_base, ".tsv"))

# convert my_data into long format
my_data_long <- melt(my_data_wide, id.vars = "year", 
                     measure.vars = c("exports", "imports"), 
                     variable.name = "type", value.name = "pounds")

p <- ggplot(my_data_long, aes(x = year, y = pounds, group = type)) + 
  geom_line() +
  scale_y_continuous(breaks = c(0, 0.5, 1, 1.5), limits = c(0, 1.6)) +
  labs(x = "Year", y = "Millions of Pounds") +
  ggtitle("Fig 2.14 Playfair's Balance-of-Trade Data") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_text(face = "bold", size = 10))

p <- p + annotate("text", x = 1720, y = 1.1, size = 4,
                  label = "Imports to England") +
  annotate("text", x = 1760, y = 0.35, size = 4,
           label = "Exports from England") +
  annotate("segment", x = 1720, xend = 1730, y = 1.05, yend = 1, 
           arrow = arrow(length = unit(.3, "cm"), type = "closed")) +
  annotate("segment", x = 1760, xend = 1750, y = 0.4, yend = 0.65, 
           arrow = arrow(length = unit(.3, "cm"), type = "closed"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 4)

## pedantic: missing tick marks at top of chart
