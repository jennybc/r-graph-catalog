library(ggplot2)
library(gridExtra) #arrangeGrob
library(plyr) #ddply

this_base <- "fig07-01_sunspot-data-aspect-ratio-1"

my_data <- data.frame(
  sunspots = as.numeric(sunspots),
  year = floor(time(sunspots)))

my_data_avg <- ddply(my_data, .(year), summarize, mean = mean(sunspots))

p <- ggplot(my_data_avg, aes(x = year, y = mean)) +
  geom_line() +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank())

p1 <- p +
  coord_fixed(ratio = 0.8)
p1
  
p2 <- p +
  coord_fixed(ratio = 0.055) + 
  scale_y_continuous(breaks = seq(0, 150, 50), labels = c(0, "", "", 150)) +
  labs(x = "Sunspot Number vs. Year", y = NULL)
p2    

p3 <- arrangeGrob(
  p1, p2, nrow = 2, heights = c(0.8, 0.2),
  main = textGrob("Fig 7.1 Sunspot Data: Aspect Ratio 1", 
                  just = "top", vjust = 0.75, gp = gpar(fontsize = 16, 
                                                        lineheight = 1, 
                                                        fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

