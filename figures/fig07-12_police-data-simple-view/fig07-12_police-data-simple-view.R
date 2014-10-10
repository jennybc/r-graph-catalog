library(ggplot2)

this_base <- "fig07-12_police-data-simple-view"

assaults <- c(3320, 567, 39, 52)
category <- c("Physical Force", "Other weapons", "Knife", "Firearms")

my_data <- data.frame(
	assaults = assaults,
	percent = assaults / sum(assaults) * 100, 
	category = factor(category, category))

p <- ggplot(my_data, aes(x = category, y = percent)) +
	geom_bar(stat = "identity", fill = "grey60", colour = "black") + 
	geom_text(y = c(9, 9, 5, 5), label = paste0("(", my_data$assaults, ")")) +
	theme_bw() +
	theme(panel.grid.major.x = element_blank(),
				panel.grid.major.y = element_line(colour = "grey60"),
				panel.grid.minor = element_blank(),
				axis.ticks.x = element_blank(),
				axis.title.y = element_text(face = "bold"),
				axis.title.x = element_text(hjust = 0, vjust = -1, face = "italic")) +
	scale_y_continuous(breaks = seq(0, 90, 10),
										 limits = c(0, 90),
										 expand = c(0, 0)) +
	labs(x = "The bars represent the percentage of assaults in each category, and the numbers
in parentheses represent the actual number of assaults.",
			 y = "Percent")

p <- p + ggtitle("Fig. 7.12 Police Data: Simple View") +
	theme(plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p,
			 width = 7, height = 4)

## todo : add secondary title to plot


