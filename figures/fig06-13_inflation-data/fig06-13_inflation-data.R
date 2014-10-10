library(ggplot2)
library(gridExtra)

this_base <- "fig06-13_inflation-data"

my_data <- read.delim(paste0(this_base, ".tsv"))

# x axis labels
v <- 1914:2003
v[c(seq(2, 90, 3), seq(3, 90, 3))] <- ""

p1 <- ggplot(my_data, aes(x = year, y = rate)) +
  geom_line() +
  geom_hline(aes(yintercept = c(0, 3))) + 
  geom_segment(aes(x = 1914:2003, xend =  1914:2003, 
                   y = rep(-0.5, 90), yend = rep(0.5, 90))) +
  geom_text(label = v, angle = 90, y = -3, size = 3) + 
  scale_y_continuous(breaks = seq(-15, 20, 5), limits = c(-15, 20),
                     expand = c(0, 0)) +
  scale_x_continuous(limits = c(1914, 2003), expand = c(0, 1)) +
  labs(x = "Year\n The horizontal line represents an inflation rate of three.", 
       y = "Rate") +
  ggtitle("Inflation Trend 1914 - 2003") +
  theme(panel.border = element_rect(fill = NA),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = 10, face = "bold"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title = element_text(size = 10, face = "bold")) 

p2 <- ggplot(my_data, aes(x = year, y = rate)) +
  geom_line() +
  geom_hline(aes(yintercept = c(0, 3))) + 
  scale_y_continuous(breaks = seq(-15, 20, 5), limits = c(-15, 20),
                     expand = c(0, 0)) +
  scale_x_continuous(breaks = seq(1914, 2003, 1), labels = v,
                     limits = c(1914, 2003), expand = c(0, 1)) +
  labs(x = "Year\n The horizontal line represents an inflation rate of three.", 
       y = "Rate") +
  ggtitle("Inflation Trend 1914 - 2003") + 
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90),
        axis.title = element_text(size = 10, face = "bold"))

# arrange plots together 
p3 <- arrangeGrob(
  p1, p2, nrow = 2, 
  main = textGrob(
    "Fig 6.13 Inflation Data", just = "top", vjust = 0.75, 
    gp=gpar(fontsize = 18, lineheight = 1, fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

