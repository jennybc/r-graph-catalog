## NOTE: THE DATA USED WAS ESTIMATED, WE DID NOT HAVE ACCESS TO THE
##       RAW/ORIGINAL DATA.

library(ggplot2)
library(plyr)
library(reshape2)
library(gridExtra)

this_base <- "fig05-08_monterey-bay-aquarium-data-mosaic-plot-preliminaries"

my_data <- data.frame(
  time = c("S", "M", "L"),
  dont_like = c(20, 7, 1),
  neutral = c(35, 41, 4),
  like = c(60, 114, 29))

# helper variables
my_data$total <- with(my_data, like + neutral + dont_like)
my_data$xmax <- with(my_data, cumsum(total))
my_data$xmin <- with(my_data, xmax - total)

my_data_long <- melt(my_data, c("time", "xmin", "xmax", "total"))

my_data_long$time <- factor(my_data_long$time, c("S", "M", "L"))

my_data_long1 <- ddply(my_data_long, .(time), transform, ymax = cumsum(value))
my_data_long1 <- ddply(my_data_long1, .(time), transform, ymin = ymax - value)

my_data_long1$ymin_std <- with(my_data_long1, (ymin / total) * 100)
my_data_long1$ymax_std <- with(my_data_long1, (ymax / total) * 100)


p1 <- ggplot(my_data_long, aes(x = time, y = value)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(breaks = seq(0, 150, 50), expand = c(0, 0)) + 
  theme_classic() +
  theme(axis.title = element_blank(),
        axis.ticks.x = element_blank())

p1

p2 <- ggplot(my_data_long, aes(x = time, y = value, fill = variable)) +
  geom_bar(stat = "identity", show_guide = FALSE) +
  scale_fill_manual(values = c("grey20", "grey50", "grey80")) +
  scale_y_continuous(breaks = seq(0, 150, 50), expand = c(0, 0)) + 
  theme_classic() +
  theme(axis.title = element_blank(),
        axis.ticks.x = element_blank())

p2

p3 <- ggplot(my_data_long1, 
             aes(ymin = ymin_std, ymax = ymax_std, xmin = xmin, 
                 xmax = xmax, fill = variable)) +
  geom_rect(colour = "black", show_guide = FALSE, width = 0.5) +
  scale_fill_manual(values = c("grey20", "grey50", "grey80")) +
  scale_x_continuous(breaks = c(60, 200, 295), labels = c("S", "M", "L")) +
  scale_y_continuous(breaks = c(3, 30, 75), 
                     labels = c("Don't\nLike", "Neutral", "Likes")) +
  theme_bw() +
  theme(panel.border = element_blank(),
        axis.ticks = element_blank())

p3

p4 <- arrangeGrob(
  p1, p2, ncol = 2, heights = c(0.5, 0.5))

p5 <- arrangeGrob(
  p4, p3, nrow = 2, heights = c(0.4, 0.6),
  main = textGrob(
    "Fig 5.8 Montery Bay Aquarium Data:\nMosaic Plot Preliminaries",
    just = "top", vjust = 0.75, gp = gpar(fontsize = 14, lineheight = 1, 
                                          fontface = "bold")))
p5

ggsave(paste0(this_base, ".png"), 
       p5, width = 6, height = 6)

## pedantic: missing space between bars
