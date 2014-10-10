library(ggplot2)
library(gridExtra)

this_base <- "fig06-07_superposed-data-sets-2"

biv_norm <- read.delim(paste0(this_base, ".tsv"))

p1 <- ggplot(biv_norm, aes(x = x, y = y)) +
  geom_point(aes(shape = as.factor(group)), show_guide = FALSE) +
  scale_shape_manual(values = c(65, 66, 67)) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) + 
  scale_x_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p1

p2 <- ggplot(biv_norm, aes(x = x, y = y)) +
  geom_point(aes(shape = as.factor(group)), show_guide = FALSE) +
  scale_shape_manual(values = c(1, 3, 60)) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) + 
  scale_x_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2

# arrange plots together 
p3 <- arrangeGrob(p1, p2, nrow = 2,
                  main = textGrob("Fig 6.7 Superposed Data Sets 2", 
                                  just = "top", vjust = 0.75, 
                                  gp = gpar(lineheight = 1, 
                                            fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), p3, width = 4, height = 6)

## note: my_data is simulated to resemble original

