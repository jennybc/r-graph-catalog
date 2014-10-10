library(ggplot2)
library(grid)
library(plyr)

this_base <- "fig06-08_avoiding-superposed-data"

biv_norm <- read.delim(paste0(this_base, ".tsv"))
biv_norm$grp <-
  mapvalues(biv_norm$group, from = 1:3, to = paste("Group", LETTERS[1:3]))

## y jitter not clearly necessary, but present in the original figure
p <- ggplot(biv_norm, aes(x = x, y = jitter(y, 2))) +
  geom_point() +
  facet_wrap(~ grp) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 45),
                     expand = c(0, 0)) + 
  scale_x_continuous(breaks = seq(0, 40, 20), minor_breaks = c(10, 30),
                     limits = c(0, 45), expand = c(0, 0)) +
  labs(x = "X", y = "Y") +
  ggtitle("Fig 6.8 Avoiding Superposed Data") +
  theme_bw() +
  theme(panel.grid.major = element_line(colour = "grey60"),
        panel.grid.minor = element_line(linetype = "dotted", colour = "grey60"),
        panel.margin = unit(0, "lines"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        strip.background = element_rect(fill = "white"))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 4)

## pedantic: x axis at top for middle facet
