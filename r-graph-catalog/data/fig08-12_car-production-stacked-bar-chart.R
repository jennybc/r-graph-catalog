library(ggplot2)
library(plyr)
library(reshape2)

this_base <- "fig08-12_car-production-stacked-bar-chart"

my_data <- data.frame(
  year = c("1980", "1979", "1978", "1977"),
  usa = c(22.0, 27.2, 29.1, 30.0),
  west_germany = c(12.2, 12.7, 12.4, 12.4),
  france = c(12.0, 12.0, 11.5, 11.6), 
  japan = c(24.3, 19.9, 19.0, 17.7),
  other = c(29.5, 28.0, 28.0, 28.2))

my_data_long <- melt(my_data, id.vars = "year",
                  measure.vars = c("japan", "usa", "west_germany", 
                                   "france", "other"),
                  variable.name = "country", value.name = "production")

my_data_long$country <-factor(my_data_long$country,
                           c("usa","west_germany", "france", "japan", "other"))

my_data_long <- arrange(my_data_long, country)

percent_sign <- function (x) { paste0(x, "%") }

p <- ggplot(my_data_long, aes(x = year, y = production, fill = country)) +
  geom_bar(stat="identity", width = 0.7, colour = "black") +
  scale_fill_manual(values = c("black",  "grey50", "grey30", "white", "grey70"),
                    labels = c("USA", "West Germany", 
                               "France", "Japan", "Other")) +
  scale_y_continuous(breaks = seq(0, 100, 20), limits = c(0, 100), 
                     expand = c(0, 0), labels = percent_sign) + 
  ggtitle("Fig 8.12 Car Production: Stacked Bar Chart") + 
  coord_flip() +
  theme_bw() +
  theme(panel.grid.major.x = element_line(colour = "grey60"),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"),
        axis.title = element_blank(),
        axis.ticks.y = element_blank(),
        legend.position = "top",
        legend.title = element_blank()) 

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 5)

