library(ggplot2)
library(gridExtra) #arrangeGrob()

this_base <- "fig04-07_avoid-misleading-histograms"

my_data <- data.frame(
  value = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 
            2, 2, 2, 2, 2, 3, 3, 3, 3, 3,
            3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
            4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
            4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
            5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
            5, 5, 5, 5, 5, 6, 6, 6, 6, 6,
            6, 6, 6, 6, 6, 7, 7, 7, 7, 7)
)

p1 <- ggplot(my_data, aes(x = value)) + 
  geom_histogram(binwidth = 1, fill = 'white', colour = 'black', origin = 0.5) +
  scale_x_continuous(breaks = seq(0, 8, 2), limits = c(0, 8), 
                     expand = c(0, 0.1)) +
  scale_y_continuous(breaks = seq(0, 25, 5), limits = c(0, 25), 
                     expand = c(0, 0.5)) +
  theme_classic() +
  theme(axis.title = element_blank())


p2 <- ggplot(my_data, aes(x = value)) + 
  geom_histogram(binwidth = 1.4, fill = 'white', colour = 'black', 
                 origin = 0.5) + 
  scale_x_continuous(breaks = seq(0,8,2), limits = c(0, 8), 
                     expand = c(0, 0.1)) +
  scale_y_continuous(breaks = seq(0, 25, 5), limits = c(0, 25), 
                     expand = c(0, 0.5)) +
  theme_classic() +
  theme(axis.title = element_blank()) 


# arrange plots together 
p3 <- arrangeGrob(p1, p2, nrow = 2,
                  main = textGrob("Fig. 4.7 Avoid Misleading Histograms", 
                                  just = "top", gp = gpar(fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 4, height = 6)

## pedantic: missing gap between axis at origin


