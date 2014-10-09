library(ggplot2)
library(reshape2)
library(plyr)

this_base <- "fig05-14_nightingale-data"

my_data <- read.delim(paste0(this_base, ".tsv"))

my_data$Date <- as.Date(paste("01", my_data$Month , my_data$Year, sep = "-"),
                        format = "%d-%b-%Y")
my_data <- subset(my_data, Date < as.Date("1855-04-01"), 
                  c(Date, Zymotic.Diseases.Rate,
                    Wounds.and.Injuries.Rate, All.Other.Causes.Rate))
my_data <- rename(my_data, c("Zymotic.Diseases.Rate" = "disease",
                             "Wounds.and.Injuries.Rate" = "wounds",
                             "All.Other.Causes.Rate" = "other"))

my_data_long <-
  melt(my_data, id = "Date", variable.name = "Cause", value.name = "Deaths")
my_data_long$Cause <-
  factor(my_data_long$Cause, c("wounds", "disease", "other"))

# labels for wedges
date_labels <- format(my_data_long$Date, format = "%B")
date_labels[which(date_labels == "April")] <- "April 1954"
date_labels[which(date_labels == "January")] <- "January 1955"
date_labels[which(date_labels == "March")] <- "March 1955"

p <- ggplot(my_data_long, aes(x = factor(Date), y = Deaths, fill = Cause)) +
  # do it as a stacked bar chart first
  geom_bar(width = 1, position = "identity", 
           stat = "identity", colour = "black", show_guide = FALSE) +
  scale_x_discrete(labels = date_labels) +
  # set scale so area ~ Deaths	
  scale_y_sqrt() + 
  scale_fill_manual(values = c("grey80", "grey40", "grey60")) +
  # A coxcomb plot = bar chart + polar coordinates
  coord_polar(start = 3*pi/2) + 
  ggtitle("Fig 5.14 Nightingale Data") +
  theme_bw() +
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.1), face = "bold", vjust = 1),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size = 8))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 6)

## pedantic: labelling of wedges 
