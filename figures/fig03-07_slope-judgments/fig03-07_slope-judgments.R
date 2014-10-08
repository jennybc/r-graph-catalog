library(ggplot2)
library(gridExtra)

this_base <- "fig03-07_slope-judgments"

data1 <- data.frame(
  x = c(0, 10),
  y = c(0, 1))

data2 <- data.frame(
  x = c(0, 10),
  y = c(0, 10))

data3 <- data.frame(
  x = c(0, 10),
  y = c(10, 0))

data4 <- data.frame(
  x = c(0, 1),
  y = c(0, 10))


p1 <- ggplot(data1, aes(x = x, y = y)) +
  geom_line() +
  scale_x_continuous(breaks = seq(0, 10, 2)) +
  scale_y_continuous(breaks = seq(0, 10, 2), limits = c(0, 10)) +
  theme_bw() +
  theme(panel.grid.major = element_blank())

p2 <- ggplot(data2, aes(x = x, y = y)) +
  geom_line() +
  scale_x_continuous(breaks = seq(0, 10, 2)) +
  scale_y_continuous(breaks = seq(0, 10, 2)) +
  theme_bw() +
  theme(panel.grid.major = element_blank())

p3 <- ggplot(data3, aes(x = x, y = y)) +
  geom_line() +
  scale_x_continuous(breaks = seq(0, 10, 2)) +
  scale_y_continuous(breaks = seq(0, 10, 2)) +
  theme_bw() +
  theme(panel.grid.major = element_blank())

p4 <- ggplot(data4, aes(x = x, y = y)) +
  geom_line() +
  scale_x_continuous(limits = c(0, 10), breaks = seq(0, 10, 2)) +
  scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, 2)) +
  theme_bw() +
  theme(panel.grid.major = element_blank())

p <- arrangeGrob(p1, p2, p3, p4 , ncol = 2,
                 main = textGrob("Fig 3.7 Slope Judgments",
                                 just = "top", vjust = 0.75, 
                                 gp = gpar(fontface = "bold")))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 5, height = 5)


