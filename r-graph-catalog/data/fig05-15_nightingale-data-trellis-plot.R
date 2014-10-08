library(ggplot2)
library(gridExtra)
library(scales)
library(reshape2)

this_base <- "fig05-15_nightingale-data-trellis-plot"

my_data <- read.delim(paste0(this_base, ".tsv"))

my_data$Date <- 
  as.Date(paste("01",my_data$Month ,my_data$Year, sep = "-"), format = "%d-%b-%Y")

my_data <- subset(my_data, 
               select = c(Date, Zymotic.Diseases.Rate : All.Other.Causes.Rate))

names(my_data) <- c("Date", "disease", "wounds", "other")

my_data_long <- melt(my_data, id.vars = "Date")

my_data_long$variable <- 
  factor(my_data_long$variable, c("other", "wounds", "disease"))

p <- ggplot(my_data_long, aes(x = Date, y = value)) +
  geom_line() +
  facet_wrap(~ variable, nrow = 3) +
  scale_x_date(breaks = "3 months", labels = date_format("%b"),
               limits = c(min(my_data_long$Date), max(my_data_long$Date)),
               expand = c(0.1, 0)) +
  scale_y_continuous(breaks = c(500, 1000)) +
  labs(x = NULL, y = "Death rate per thousand") +
  ggtitle("Fig 5.15 Nightingale Data: Trellis Plot") + 
  theme_bw() + 
  theme(panel.grid.major = element_line(colour = "grey60"),
        panel.grid.minor = element_blank(),
        panel.margin = unit(0, "lines"),
        plot.title = element_text(size = rel(1.1), face = "bold", vjust = 1)) 

yr1 <- "1854"
yr2 <- "1855"
yr3 <- "1856"

p1 <- arrangeGrob(p, sub = textGrob(paste(yr1, "\n"), 
                                    x = 0.3, vjust = 0.75, 
                                    gp = gpar(fontsize = 10))) 
p2 <-	arrangeGrob(p1, sub = textGrob(paste(yr2), 
                                     x = 0.6, vjust = -1.75, 
                                     gp = gpar(fontsize = 10))) 
p3 <-	arrangeGrob(p2, sub = textGrob(paste(yr3), 
                                     x = 0.85, vjust = -2.75, 
                                     gp = gpar(fontsize = 10)))

p3

ggsave(paste0(this_base, ".png"), p3, width = 6, height = 5)

