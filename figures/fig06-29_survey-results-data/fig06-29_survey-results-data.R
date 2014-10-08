library(ggplot2)
library(reshape2)

this_base <- "fig06-29_survey-results-data"

my_data <- 
  data.frame(year = c(1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998,
                      1999, 2000, 2001, 2002, 2003),
             survey1 = c(25.5, 23, 26, 24, 26, 25, 24, 22.5, 22, 21, 
                         17.5, 18.5, 16),
             survey2 = c(14.5, 15, 18, 16, 16, 18, 28, 28.5, 32.5, 33, 
                         36, 21, 21.5), 
             survey3 = c(10, 13, 22.5, 13, 14, 9, 12, 14, 13, 14, 
                         14, 17, 19.5))

my_data_long <- melt(my_data, "year")

p <- ggplot(my_data_long, aes(x = year, y = value)) +
  geom_line(aes(linetype = variable), show_guide = FALSE) +
  scale_linetype_manual(values = c("solid", "longdash", "dashed")) +
  scale_x_continuous(breaks = seq(1991, 2003, 3)) +
  scale_y_continuous(breaks = seq(0, 40, 5), limits = c(0, 40), 
                     expand = c(0, 0)) +
  labs(x = NULL, y = "Percent Naming issue") + 
  ggtitle(expression(atop(bold("Fig 6.29 Survey Results Data"), 
                          atop("Top Three Issues Identified by Survey")))) +
  theme(panel.grid.major.y = element_line(colour = "grey60"), 
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.title.y = element_text(face = "bold"))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)


## note: my_data is estimated

