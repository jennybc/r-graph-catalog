library(ggplot2)

this_base <- "fig07-16_temperature-data-two-scales"

my_data <- data.frame(
  month = month.abb, 
  fahrenheit = c(31, 33, 41, 50, 60, 69, 74, 73, 66, 55, 45, 35))

my_data$month <- factor(my_data$month, month.abb)

p <- ggplot(my_data, aes(x = as.numeric(factor(month)), y = fahrenheit)) +
  geom_point(shape = 9) +
  geom_text(aes(label = "Celcius"), x = 14, y = 50, angle = 90) +
  scale_x_continuous(breaks = seq(1, 12, 1), limits = c(1, 12), 
                     labels = my_data$month) +
  labs(x = "Monthly Mean Temperatures for Atlantic City, NJ", 
       y = "Fahrenheit") +
  ggtitle("Fig 7.16 Temperature Data: Two Scales") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold"))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## TO DO: add the Celsius scale? 
## note: my_data is estimated
