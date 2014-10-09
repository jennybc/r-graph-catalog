library(ggplot2)
library(reshape2) # melt()
library(grid) # arrow()
library(gridExtra) #arrangeGrob()

this_base <- "fig02-15_playfair-s-balance-of-trade-data-imports-minus-export"

my_data_wide <- read.delim(paste0(this_base, ".tsv"))

# convert my_data into long format
my_data_long <- melt(my_data_wide,
                     id.vars = "year", measure.vars = c("exports", "imports"), 
                     variable.name = "type", value.name = "pounds")

p1 <- ggplot(my_data_long, aes(x = year, y = pounds, group = type)) + 
  geom_line() +
  scale_y_continuous(breaks = c(0, 0.5, 1, 1.5), limits = c(0, 1.6)) +
  labs(x = "Imports and Exports", y = "Millions of Pounds") +
  theme_bw() +
  theme(legend.position = "none",
        panel.grid.major = element_blank(),
        axis.title = element_text(face = "bold"))

p1 <- p1 + annotate("text", x = 1720, y = 1.1, size = 4,
                    label = "Imports to England") +
  annotate("text", x = 1760, y = 0.35, size = 4,
           label = "Exports from England") + 
  annotate("segment", x = 1720, xend = 1730, y = 1.05, yend = 1, 
           arrow = arrow(length = unit(.3, "cm"), type = "closed")) +
  annotate("segment", x = 1760, xend = 1750, y = 0.4, yend = 0.65, 
           arrow = arrow(length = unit(.3, "cm"), type = "closed"))

p2 <- ggplot(my_data_wide, aes(x = year, y = difference)) + 
  geom_line() +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2), limits = c(0, 1)) +
  labs(x = "Imports Minus Exports", y = "Millions of Pounds") +
  theme_bw() +
  theme(legend.position = "none",
        panel.grid.major = element_blank(),
        axis.title = element_text(face = "bold")) 

# arrange plots together 
p3 <- arrangeGrob(
  p1, p2, nrow = 2, heights = c(0.65, 0.35),
  main = textGrob(
    "Fig 2.15 Playfair's Balance-of-Trade Data:\nImports Minus Exports",
    just = "top", vjust = 0.75, gp = gpar(fontsize = 14, lineheight = 1, 
                                          fontface = "bold")))

p3

# must pass in p3 since arrangeGrob doesnt return ggplot object
ggsave(paste0(this_base, ".png"), p3, width = 6, height = 6)

## pedantic: missing tick marks at top and right side of plots
