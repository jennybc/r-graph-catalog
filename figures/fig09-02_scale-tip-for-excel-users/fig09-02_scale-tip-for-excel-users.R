library(ggplot2)
library(gridExtra)

this_base <- "fig09-02_scale-tip-for-excel-users"

my_data <- data.frame(year = c(1914, 1931, 1936, 1942, 1952, 1962),
                   year_2 = c(1910, 1920, 1930, 1940, 1950, 1960),
                   acres = c(16, 43, 80, 95, 110, 138))

p1 <- ggplot(my_data, aes(x = year_2, y = acres)) +
  geom_point() + geom_line() +
  scale_x_continuous(breaks = seq(1910, 1960, 10), 
                     labels = c(1914, 1930, 1935, 1940, 1950, 1960),
                     limits = c(1905, 1970), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 160, 20), limits = c(0, 160),
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Number of Acres") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey60"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.y = element_text(face = "bold"))

p1

p2 <- ggplot(my_data, aes(x = year, y = acres)) +
  geom_point() + geom_line() +
  scale_x_continuous(breaks = seq(1910, 1970, 10), limits = c(1910, 1970), 
                     expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 160, 20), limits = c(0, 160),
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Number of Acres") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey60"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.y = element_text(face = "bold"))

p3 <- arrangeGrob(p1, p2, ncol = 1,
                  main = textGrob("Fig 9.2 Scale Tip for Excel Users",
                                  vjust = 0.75, gp = gpar(fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

## note: my_data is estimated
