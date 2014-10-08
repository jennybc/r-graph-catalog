library(ggplot2)
library(gridExtra) #arrangeGrob()

this_base <- "fig04-06_families-exhibition-histogram"

time <- seq(1:85)
count <- c(0,0, 12, 6, 9, 2, 5, 4, 4, 5, 6, 3, 4, 8, 4, 
           5, 2, 4, 3, 2, 1, 2, 2, 0, 5, 1, 2, 1,
           3, 0, 1, 2, 0, 1, 2, 1, 1, 2, 0, 0, 1,
           0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,
           0, 0, 0, 0, 0, 0, 1, 0, 0, 0, rep(0, 18), 1, 0, 0)

my_data <- data.frame(rep(time, count))
names(my_data) <- "minutes"

p1 <- ggplot(my_data, aes(x = minutes)) + 
  geom_histogram(binwidth = 10, fill = 'grey40', colour = 'white', origin = 1) +
  scale_x_continuous(breaks = seq(0, 100, 20), limits = c(-5, 100), 
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 40, 10), limits = c(0, 50), 
                     expand = c(0, 2)) +
  labs(x = "Time (minutes)", y = "Count of Visitors") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2 <- ggplot(my_data, aes(x = minutes)) + 
  geom_histogram(binwidth = 1, fill = 'grey40', colour = 'white') +
  scale_x_continuous(breaks = seq(0,100,20), limits = c(-5, 100), 
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0,12,2), expand = c(0, 0.5)) +
  labs(x = "Time (minutes)", y = "Count of Visitors") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# arrange plots together 
p3 <- arrangeGrob(p1, p2, nrow = 2,
                  main = textGrob("Fig. 4.6 Families Exhibition: Histogram", 
                                  just = "top", gp = gpar(fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

## TODO: missing reference bar to right of plot


