library(ggplot2)
library(grid) # unit()
library(reshape2) # melt()
library(plyr)

this_base <- "fig05-03_energy-data-trellis-display"

my_data <- data.frame(
  year = c(1977, 1978, 1979, 1980, 1981, 1982, 1983, 1984, 1985, 1986),
  us = c(1320, 1280, 1350, 1400, 1470, 1420, 1440, 1580, 1520, 1605),
  japan = c(405, 405, 480, 500, 490, 495, 480, 480, 500, 530),
  germany = c(220, 225, 290, 320, 300, 280, 260, 240, 220, 225),
  other = c(1280, 1195, 1310, 1390, 1270, 1200, 1100, 1100, 1040, 1080))

my_data_long <- melt(my_data, id.vars = c("year"),
                  measure.vars = c("us", "japan", "germany", "other"), 
                  variable.name = "country")

my_data_long$country <- factor(my_data_long$country, 
                            levels = c("other", "us", "germany", "japan"))

my_data_long$year <- as.numeric(as.character(my_data_long$year))

# rename variables in my_data frame 
my_data_long$country <- 
  revalue(my_data_long$country, 
          c("other" = "Country: All Other OECD", "us" = "Country: US",
            "germany" = "Country: West Germany", "japan" = "Country: Japan"))

p <- ggplot(my_data_long, aes(x = year, y = value)) +
  geom_point(shape = 1) +
  facet_wrap(~ country) +
  scale_x_continuous(breaks = seq(1976, 1986, 2), limits = c(1975, 1986),
                     labels = c(1976, "", 1980, "", 1984, "")) +
  scale_y_continuous(breaks = seq(200, 1600, 200)) +
  labs(x = "Year", y = "Millions of Gallons") +
  ggtitle("Fig 5.3 Energy Data: Trellis Display") + 
  theme_bw() +
  theme(panel.margin = unit(0, "cm"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        strip.background = element_rect(fill = "white"))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)


## note: my_data is estimated 
