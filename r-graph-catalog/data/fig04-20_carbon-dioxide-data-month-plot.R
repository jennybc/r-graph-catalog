library(ggplot2)
library(plyr)
library(grid) # unit()

this_base <- "fig04-20_carbon-dioxide-data-month-plot"

co2_trim <- window(co2, c(1959, 1), c(1990, 12))
fit <- stl(co2_trim, s.window = 20, t.window = 20)

my_data <- data.frame(
  month = factor(1:12, labels = month.abb),
  x = time(fit$time.series), 
  fit$time.series)

p <- ggplot(my_data, aes(x = x, y = seasonal)) +
  geom_line() +
  facet_wrap(~ month, nrow = 1) +
  stat_smooth(method = "lm", formula = y ~ 1, se = FALSE, colour = "black") +
  scale_x_continuous(labels = c("", "", "", 30)) +
  scale_y_continuous(breaks = seq(-2, 2, 2), limits = c(-3.5, 3.5), 
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Carbon Dioxide (ppm)") +
  ggtitle("Fig 4.20 Carbon Dioxide Data: Month Plot") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        panel.margin = unit(0, "cm")) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 5, height = 6)

## pedantic: missing x axis at top of chart 

