library(ggplot2)
library(gridExtra)

this_base <- "fig07-23_annual-report-no-y-scale"

my_data <- data.frame(
  year = c(1998, 1999, 2000, 2001, 2002, 2003),
  income = c(76461, 143252, 170534, 235486, 272693, 340105))

p1 <- ggplot(my_data, aes(x = year, y = income / 1000)) +
  geom_line() +
  geom_point(shape = 21, fill = "white") +
  geom_text(y = (my_data$income / 1000) + 25, size = 3, 
            label = my_data$income) +
  scale_y_continuous(limits = c(0, 450), expand = c(0, 0)) +
  ggtitle("Net Income") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_text(colour = "white"),
        axis.ticks.y = element_blank(),
        axis.title = element_blank())

p1

p2 <- ggplot(my_data, aes(x = year, y = income / 1000)) +
  geom_line() +
  geom_point(shape = 21, fill = "white") +
  scale_y_continuous(breaks = seq(0, 400, 100), limits = c(0, 450),
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Net Income (thousands of dollars)") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

p2

p3 <- arrangeGrob(
  p1, p2, nrow = 2,
  main = textGrob("Fig 7.23 Annual Report: No Y Scale", 
                  just = "top", vjust = 0.75, gp = gpar(fontsize = 16, 
                                                        lineheight = 1, 
                                                        fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), p3, width = 5, height = 6)

