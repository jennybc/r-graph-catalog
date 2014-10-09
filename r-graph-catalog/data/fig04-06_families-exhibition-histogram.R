library(ggplot2)
library(gridExtra) #arrangeGrob()

this_base <- "fig04-06_families-exhibition-histogram"

my_freq <- read.table("families_frequencies.txt", header = TRUE)
my_data <- with(my_freq, data.frame(minutes = rep(minutes, freq)))

p1 <- ggplot(my_data, aes(x = minutes)) + 
  geom_histogram(binwidth = 10, fill = 'grey40', colour = 'white', origin = 0) +
  scale_x_continuous(breaks = seq(0, 100, 20), limits = c(-5, 100), 
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 40, 10), expand = c(0, 2)) +
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


