library(ggplot2)
library(reshape2)

this_base <- "fig08-13_car-production-trellis-panels"

my_data <- data.frame(
  year = c(1977, 1978, 1979, 1980),
  USA = c(30.0, 29.1, 27.2, 22.0),
  West.Germany = c(12.4, 12.4, 12.7, 12.2),
  France = c(11.6, 11.5, 12.1, 12.0), 
  Japan = c(17.7, 19.0, 19.9, 24.3),
  Other = c(28.3, 28.0, 28.1, 29.5))

my_data_long <- melt(my_data, id.vars = "year",
                     measure.vars = c("Japan", "USA", "West.Germany",
                                      "France", "Other"),
                     variable.name = "country", value.name = "production")

my_data_long$country <- with(my_data_long, reorder(country, production, max))

p <- ggplot(my_data_long, aes(x = year, y = production)) +
  geom_line() +
  geom_point() +
  facet_grid(~ country) +
  scale_x_continuous(labels = c(1977, "", 1979, "")) +
  labs(x = "Year", y = "Percent") +
  ggtitle("Fig 8.13 Car Production: Trellis Panels") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold", vjust = 2))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 6)

# note: my_data doesnt quite match with fig 8.13

