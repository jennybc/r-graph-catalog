library(ggplot2)
library(gridExtra)

this_base <- "fig06-25_america-online-market-value"

my_data <- data.frame(
  x = c(1, 1, 3, 0.8, 0.8, 1.2, 0.66, 0.66, 1.34), 
  y = c(1, 3, 2, 1.8, 2.2, 2, 1.5, 2.5, 2), 
  id = rep(c("large_tri", "small_tri", "med_tri"), each = 3))


my_data1 <- subset(my_data, id != "med_tri")
my_data2 <- subset(my_data, id != "small_tri")

p1 <- ggplot(my_data1, aes(x = x, y = y, group = id, fill = id)) + 
  geom_polygon(colour = "black") +
  annotate("segment", x = c(0.9, 2), xend = c(0.9, 2), y = c(3.5, 3.5), 
           yend = c(2, 2), lineend = "round") +
  annotate("point", x = c(0.9, 2), y = c(2, 2)) +
  annotate("text", x = c(1.1, 2.15), y = c(3.5, 3.5), 
           label = c("$26.4", "$114.6"), size = 3) +
  scale_fill_manual(values = c("grey50", "grey60"), guide = FALSE) +
  scale_x_continuous(limits = c(0.5, 3)) +
  ggtitle("Fig 6.25 America Online Market Value") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank())

p2 <- ggplot(my_data2, aes(x = x, y = y, group = id, fill = id)) + 
  geom_polygon(colour = "black") +
  annotate("segment", x = c(0.9, 2), xend = c(0.9, 2), y = c(3.5, 3.5), 
           yend = c(2, 2), lineend = "round") +
  annotate("point", x = c(0.9, 2), y = c(2, 2)) +
  annotate("text", x = c(1.1, 2.15), y = c(3.5, 3.5), 
           label = c("$26.4", "$114.6"), size = 3) +
  scale_fill_manual(values = c("grey50", "grey60"), guide = FALSE) +
  scale_x_continuous(limits = c(0.5, 3)) +
  ggtitle("+334.1%\nAmerica Online") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = rel(0.8)),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank())

p3 <- arrangeGrob(p1, p2, main = "")

p3

ggsave(paste0(this_base, ".png"), p3, width = 4, height = 6)

## note: my_data is estimated
