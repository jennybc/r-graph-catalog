library(ggplot2)
library(scales) #scale_x_date()
library(gridExtra) 

this_base <- "fig07-04_carbon-dioxide-aspect-ratio-changed"

my_data <- data.frame(
	co2 = as.numeric(co2),
	date = seq(as.Date("1959-01-01"),  by = "month", length.out = 12*39)
)

my_data <- subset(my_data, date < as.Date("1991-01-01"))

datebreaks <- seq(as.Date("1960-01-01"),
									as.Date("1990-12-01"), by = "5 year")

p <- ggplot(my_data, aes(x = date, y = co2)) +
	stat_smooth(method = "loess", se = FALSE, colour = "black") +
	theme_bw() +
	theme(panel.grid.major = element_blank(),
				panel.grid.minor = element_blank(),
				axis.title.y = element_text(size = 8)) +
	labs(x = NULL,
			 y = "Carbon Dioxide (ppm)")
p

p1 <- p +
  coord_fixed(ratio = 40)
p1

p2 <- p + scale_y_continuous(breaks = seq(320, 350, 10), 
															limits = c(310, 360)) +
	scale_x_date(breaks = datebreaks, labels = c(1960, "", 1970, "", 1980, "", 1990),
							 limits = c(as.Date("1960-01-01"),
							 					 as.Date("1990-12-01"))) +
  coord_fixed(ratio = 500)
p2

p3 <- p3 <- arrangeGrob(p1, p2, nrow = 2, heights = c(0.2, 0.8),
												main = textGrob("Fig 7.4 Carbon Dioxide: Aspect\nRatio Changed", 
																				just = "top", vjust = 0.75, 
																				gp = gpar(fontsize = 17, 
																									lineheight = 1, 
																									fontface = "bold")))

p3

ggsave(paste0(this_base, ".png"), 
			 p3, width = 6, height = 6)



