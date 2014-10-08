library(ggplot2)
library(gridExtra)

this_base <- "fig07-25_annual-report-data-tick-marks-at-hard-to-judge-values"

my_data <- data.frame(year = c(1998, 1999, 2000, 2001, 2002),
                   value = c(74, 111, 195, 350, 390))

p <- ggplot(my_data, aes(x = year, y = value)) +
  geom_bar(stat = "identity", colour = "black", fill = "grey60") +
  scale_y_continuous(breaks = seq(0, 444, 37), limits = c(0, 444), 
                     expand = c(0, 0)) +
  ggtitle("Net Income (thousands)") + 
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank())

p <- arrangeGrob(p, main = textGrob(
  "Fig 7.25 Annual Report Data: Tick Marks \n at Hard-to-Judge Values",
  just = "top", vjust = 0.75, gp = gpar(fontface = "bold")))

p

# must pass in p3 since arrangeGrob doesnt return ggplot object
ggsave(paste0(this_base, ".png"),
       p, width = 6, height = 4)

## note: my_data is estimated
