library(ggplot2)
library(gridExtra)

this_base <- "fig07-14_sales-data-avoiding-a-scale-break"

set.seed(0)

x <- c(rnorm(400, 10, 3), runif(20, min = 0, max = 100))

my_data <- data.frame(value = sample(x, 420), location = c(1:420))

p1 <- ggplot(my_data, aes(x = location, y = sort(value))) +
  geom_rect(xmin = 0, xmax = 420, ymin = 0, ymax = 20, 
            fill = "grey60", alpha = 0.1) +
  geom_point(shape = 1) +
  scale_y_continuous(breaks = seq(0, 100, 20)) +
  labs(x = "Location (ordered by items sold)", 
       y = "Items Sold (thousands)") +
  ggtitle("All of the data") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p1

p2 <- ggplot(my_data, aes(x = location, y = sort(value))) +
  geom_point(shape = 1) +
  scale_y_continuous(breaks = seq(0, 20, 5)) +
  coord_cartesian(ylim = c(0, 20)) +
  labs(x = "Location (ordered by items sold)", 
       y = "Items Sold (thousands)") +
  ggtitle("Magnified view of shaded area") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2

p3 <- arrangeGrob(p1, p2, 
            main = textGrob("Fig 7.14 Sales Data: Avoiding a Scale Break", 
                            gp = gpar(fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), p3, width = 5, height = 7)

## note: data is simulated 

