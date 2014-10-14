## NOTE: THE DATA USED WAS ESTIMATED, WE DID NOT HAVE ACCESS TO THE
##       RAW/ORIGINAL DATA.

library(ggplot2)
library(reshape2)
library(grid)

this_base <- "fig04-18_slsc-visitors-month-plot"

data <- data.frame(
  time = seq(as.Date("1998-01-01"), as.Date("2002-05-01"), by = "month"),
  visitors = c(75, 80, 95, 85, 87, 140, 165, 137, 77, 90, 88, 
               76, 70, 78, 90, 77, 78, 125, 164, 126, 71, 72, 
               65, 60, 66, 78, 115, 77, 77, 135, 157, 118, 60, 
               55, 53, 48, 75, 74, 115, 77, 78, 140, 210, 142, 
               60, 55, 56, 75, 80, 80, 145, 115, 70)*1000)

data$month <- months(data$time, abbreviate = TRUE)
data$month <- factor(data$month, month.abb)
data$year <- as.numeric(format(data$time, format = "%Y")) 

data_long <- melt(data, c("month", "time", "year"))

p <- ggplot(data_long, aes(x = time, y = value)) +
  geom_point(aes(group = year)) +
  geom_line() +
  stat_smooth(method = "lm", formula = y ~ 1, se = FALSE, colour = "black") +
  facet_wrap(~ month, nrow = 1) +
  labs(x = NULL, y = "Number of Visitors") +
  ggtitle("Fig 4.18 SLSC Visitors: Month Plot") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.margin = unit(0, "lines"),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        strip.background = element_rect(fill = "white"))

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 6)

## pedantic: panel borders and position of x axis 

