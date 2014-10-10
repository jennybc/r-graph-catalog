library(ggplot2)
library(gridExtra) #arrangeGrob

this_base <- "fig07-02_annual-report-aspect-ratio-2"

my_data <- data.frame(
  income = c(117187, 202796, 357284, 392216, 163811),
  year = c(1999, 2000, 2001, 2002, 2003))

p <- ggplot(my_data, aes(x = year, y = income / 1000)) +
  geom_line() +
  geom_point(shape = 21, size = 3, fill = "white") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
p

p1 <- p +
  geom_text(x = my_data$year, y = ((my_data$income / 1000) + 60), 
            label = my_data$income, size = 3) +
  coord_fixed(ratio = 0.0008) +
  scale_y_continuous(breaks = c(0, 400), limits = c(0, 460)) +
  theme(axis.title = element_blank(),
        axis.text.y = element_blank()) 
p1

p2 <- p +
  scale_y_continuous(breaks = seq(0, 400, 100), limits = c(0, 400)) +
  coord_fixed(ratio = 0.01) +
  labs(x = NULL, y = "Net Income (thousands)") +
  theme(axis.title.x = element_blank()) 
p2

p3 <- arrangeGrob(
  p1, p2, nrow = 2, heights = c(0.25, 0.75),
  main = textGrob("Fig 7.2 Annual Report: Aspect Ratio 2", 
                  just = "top", vjust = 0.75, gp = gpar(fontsize = 16, 
                                                        lineheight = 1, 
                                                        fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
       p3, width = 6, height = 6)

