library(ggplot2)
library(gridExtra) #arrangeGrob()

this_base <- "fig07-05_annual-report-bar-chart-no-zero"

my_data <- data.frame(
  year = c(95, 96, 97, 98, 99),
  revenue = c(15048, 16451, 17699, 19613, 22982))

p1 <- ggplot(my_data, aes(x = year, y = revenue)) +
  geom_bar(stat = "identity", fill = "grey50", colour = "black", width = 0.4) +
  geom_text(aes(label = revenue), vjust = -1) +
  scale_y_continuous(limits = c(0, 25000), expand = c(0, 0)) + 
  coord_cartesian(ylim = c(14500, 25000)) +
  labs(x = "Year", y = NULL) +
  ggtitle("Operating Revenues (millions)") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_text(colour="white"),
        axis.ticks.y = element_blank(),
        axis.title.x = element_text(face = "bold"))

p2 <- ggplot(my_data, aes(x = year, y = revenue)) +
  geom_bar(stat = "identity", fill = "grey50", colour = "black", width = 0.4) +
  scale_y_continuous(breaks = seq(0, 25000, 5000), limits = c(0, 25000),
                     expand = c(0, 0)) +
  labs(x = "Year", y = NULL) +
  ggtitle("Operating Revenues (millions)") +
  theme_bw() +
  theme(panel.grid.major.y = element_line(colour = "grey40"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(face = "bold"))

# arrange plots together 
p3 <- arrangeGrob(
  p1, p2, nrow = 2,
  main = textGrob("Fig. 7.5 Annual Report Bar Chart: No Zero", 
                  just = "top", gp = gpar(fontface = "bold", cex = 1.5)))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

## pedantic: tick marks between bars instead of centre


