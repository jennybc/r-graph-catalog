library(ggplot2)
library(scales) #date_format()
library(grid) #unit()
library(reshape2)
library(plyr) # revalue()

this_base <- "fig07-21_blood-level-data-multipanel-plot"

my_data <- 
  data.frame(time = as.Date(c("1990-11-01", "1991-06-01", "1991-12-01",
                              "1992-05-01", "1993-06-01", "1994-07-01",
                              "1995-06-01", "1996-07-01", "1997-01-01", 
                              "1997-07-01", "1997-08-01", "1998-05-01")),
             C = c(195, 198, 198, 205, 207, 190, 212, 230, 227, 222, 220, 231),
             T = c(120, 111, 150, 104, 125, 160, 85, 100, 103, 188, 120, 170),
             L = c(118, 140, 125, 135, 132, 123, 146, 150, 135, 130, 145, 138),
             H = c(47.5, 43.0, 45.2, 53.4, 53.4, 42.2, 
                   45.6, 48.9, 51.6, 42.1, 47.3, 57.8),
             R = c(4.1, 4.6, 4.38, 3.84, 3.88, 4.5, 
                   4.65, 4.7, 4.4, 5.27, 4.65, 4.0))
my_data_long <- melt(my_data, id = "time",
                     variable.name = "lipid", value.name = "level")
my_data_long$lipid <- factor(my_data_long$lipid, c("R", "T", "H", "L", "C"))
my_data_long$lipid <-
  revalue(my_data_long$lipid,
          c("C" = "CHOL by Date", "T" = "TRIGLYC by Date",
            "L" = "LDL by Date", "H" = "HDL by Date",
            "R" = "CHOL/HDL by Date"))

p <- ggplot(my_data_long, aes(x = time, y = level)) +
  geom_line(aes(linetype = rev(lipid)), show_guide = FALSE) +
  facet_wrap(~ lipid, ncol = 1, scales = "free_y") + 
  scale_x_date(breaks = seq(as.Date("1990-07-01"), as.Date("1998-07-01"), 
                            "year"), labels = date_format("%b %y")) +
  ggtitle("Fig 7.21 Blood-Level Data: Multipanel Plot") + 
  theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.margin = unit(0, "lines"),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
        axis.title = element_blank(),
        strip.background = element_rect(fill = "white"))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 6)

## note: my_data is estimated

