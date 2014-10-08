library(ggplot2)
library(scales)

this_base <- "fig07-20_blood-level-data-variation-in-ratio"

my_data <- data.frame(time = c("1990-11-01", "1991-06-01", "1991-12-01",
                            "1992-05-01", "1993-06-01", "1994-07-01",
                            "1995-06-01", "1996-07-01", "1997-01-01", 
                            "1997-07-01", "1997-08-01", "1998-05-01"),
                   chol_hdl = c(4.1, 4.6, 4.38, 3.84, 3.88, 4.5, 
                                4.65, 4.7, 4.4, 5.27, 4.65, 4))

my_data$time <- as.Date(my_data$time)

p <- ggplot(my_data, aes(x = time, y = chol_hdl)) +
  geom_line() +
  geom_point(shape = 21, fill = "white") +
  scale_x_date(breaks = seq(as.Date("1990-07-01"), as.Date("1998-07-01"), 
                            "year"), labels = date_format("%b %y")) +
  scale_y_continuous(breaks = seq(3.8, 5.2, 0.2), limits = c(3.8, 5.35),
                     expand = c(0, 0)) +
  labs(x = NULL, y = "CHOL/HDL") +
  ggtitle("Fig 7.20 Blood-Level Data: Variation in Ratio") + 
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"))

p

ggsave(paste0(this_base, ".png"), 
       p, width = 6, height = 4)

## note: my_data is estimated
