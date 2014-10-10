library(ggplot2)

this_base <- "fig06-28_immigration-data-with-horizontal-baseline"

my_data <- data.frame(
	year = c("1821 - 1830", "1831 - 1840", "1841 - 1850", 
					 "1851 - 1860", "1861 - 1870", "1871 - 1880", 
					 "1881 - 1890", "1891 - 1900", "1901 - 1910", 
					 "1911 - 1920", "1921 - 1930", "1931 - 1940",
					 "1941 - 1950", "1951 - 1960", "1961 - 1970", 
					 "1971 - 1980", "1981 - 1990", "1991 - 1996"),
	immigrants = c(143, 599, 1713, 2598, 2315, 2812, 
								 5247, 3688, 8795, 5736, 4107, 528,
								 1035, 2515, 3322, 4493, 7338, 6143)
)

hhjust <- c(-0.1, -0.1, rep(1.1, 9), -0.1, rep(1.1, 6))

p <- ggplot(my_data, aes(x = year, y = immigrants, width = 0.7)) + 
	geom_bar(stat = "identity", fill = "grey50", colour = "black") +
	geom_text(aes(label = immigrants),
						size = 3,
						hjust = hhjust,
						angle = 90) +
	theme_classic() +
	theme(axis.text.x = element_text(angle = 90),
				axis.ticks.x = element_blank()) +
	scale_y_continuous(breaks = seq(0, 10000, 2000),
										 limits = c(0, 10000),
										 expand = c(0, 0)) +
  labs(x = NULL, 
       y = "Number of U.S. Immigrants (thousands)")

p <- p +
  ggtitle("Fig 6.28 Immigration Data with \n         Horizontal Baseline") + 
	theme(plot.title = element_text(size = rel(1.5), 
																	face = "bold", 
																	vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## pedantic: y axis tick marks on inside of axis


