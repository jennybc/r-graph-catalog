library(ggplot2)
library(gridExtra)

this_base <- "fig04-17_visitors-at-st-louis-science-center"

my_data <- data.frame(
  year = seq(as.Date("1998-01-01"), as.Date("2002-05-01"), by = "month"),
  visitors = c(75, 80, 95, 85, 87, 140, 165, 137, 77, 90, 88, 
               76, 70, 78, 90, 77, 78, 125, 164, 126, 71, 72, 
               65, 60, 66, 78, 115, 77, 77, 135, 157, 118, 60, 
               55, 53, 48, 75, 74, 115, 77, 78, 140, 210, 142, 
               60, 55, 56, 75, 80, 80, 145, 115, 70))

p1 <- ggplot(my_data, aes(x = year, y = visitors)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(breaks = seq(50, 200, 50), limits = c(0, 220),
                     expand = c(0, 0)) +
  coord_cartesian(ylim = c(45, 220)) +
  labs(x = NULL, y = "Number of Visitors (thousands)") +
  ggtitle("Connected Symbols") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p1

p2 <- ggplot(my_data, aes(x = year, y = visitors)) +
  geom_line() +
  scale_y_continuous(breaks = seq(50, 200, 50), limits = c(0, 220),
                     expand = c(0, 0)) +
  coord_cartesian(ylim = c(45, 220)) +
  labs(x = NULL, y = "Number of Visitors (thousands)") +
  ggtitle("Connected Plot") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2

p3 <- ggplot(my_data, aes(x = year, y = visitors)) +
  geom_point(shape = 1) +
  scale_y_continuous(breaks = seq(50, 200, 50), limits = c(0, 220),
                     expand = c(0, 0)) +
  coord_cartesian(ylim = c(45, 220)) +
  labs(x = NULL, y = "Number of Visitors (thousands)") +
  ggtitle("Symbol Plot") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p3

p4 <- ggplot(my_data, aes(x = year, y = visitors)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(breaks = seq(50, 200, 50), limits = c(0, 220),
                     expand = c(0, 0)) +
  coord_cartesian(ylim = c(45, 220)) +
  labs(x = NULL, y = "Number of Visitors (thousands)") +
  ggtitle("Vertical-Line Plot") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p4

# arrange plots together 
p5 <- arrangeGrob( p1, p2, p3, p4, nrow = 2, 
                   main = textGrob(
                     "Fig 4.17 Visitors at St. Louis Science Center",
                     just = "top", vjust = 0.75, gp = gpar(fontface = "bold")))

p5

ggsave(paste0(this_base, ".png"), p5, width = 6, height = 6)

## note: my_data is estimated
