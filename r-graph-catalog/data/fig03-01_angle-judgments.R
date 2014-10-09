library(ggplot2)

this_base <- "fig03-01_angle-judgments"

my_data <- data.frame(
  variable = c("A", "B","C","D","E"), 
  value = c(25, 55, 55, 90, 135) / 360)

p <- ggplot(my_data, aes(x = factor(1), y = value)) +
  geom_bar(width = 1, colour = "black", fill = "white", stat = "identity") + 
  coord_polar(theta = "y", start = (1/2)*pi) +
  ggtitle("Fig 3.1 Angle Judgments") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold"),
        panel.border = element_blank(),
        axis.title = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank())

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

