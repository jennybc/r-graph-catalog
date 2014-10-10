library(ggplot2)
library(gridExtra)

this_base <- "fig06-06_superposed-data-sets"

## simulate data for this series of plots
# set.seed(100)
# raw_norm <- data.frame(z1 = rnorm(99),
#                        z2 = rnorm(99))
# mu <- 23
# sigma <- 10
# rho <- 0.7
# biv_norm <- with(raw_norm,
#                  data.frame(x = mu + sigma * z1,
#                             y = mu + sigma * (z1 * rho + z2 * sqrt(1 - rho^2))))
# biv_norm$length <- with(biv_norm, sqrt(x^2 + y^2))
# biv_norm$group <- 1
# biv_norm$group[sample(99, 33, prob = biv_norm$length ^ 3)] <- 3
# biv_norm$group[sample(which(biv_norm$group == 1), 33,
#                       prob = biv_norm$length[biv_norm$group == 1]^3)] <- 2
# write.table(biv_norm, paste0(this_base, ".tsv"), sep = "\t",
#             row.names = FALSE)

biv_norm <- read.delim(paste0(this_base, ".tsv"))

p1 <- ggplot(biv_norm, aes(x = x, y = y)) +
  geom_point(aes(shape = as.factor(group)), show_guide = FALSE) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) + 
  scale_x_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p1

p2 <- ggplot(biv_norm, aes(x = x, y = y)) +
  geom_point(aes(shape = as.factor(group)), show_guide = FALSE) +
  scale_shape_manual(values = c(1, 19, 5)) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) + 
  scale_x_continuous(breaks = seq(0, 40, 10), limits = c(0, 47)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2

# arrange plots together 
p3 <- arrangeGrob(p1, p2, nrow = 2,
                  main = textGrob("Fig 6.6 Superposed Data Sets", 
                                  just = "top", vjust = 0.75, 
                                  gp = gpar(lineheight = 1, 
                                            fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), p3, width = 4, height = 6)

## note: biv_norm is simulated to resemble the original


