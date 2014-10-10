library(ggplot2)
library(reshape2)

this_base <- "fig07-30_body-mass-data-corrected"

my_data <- 
  data.frame(
    bmi = c(16, 19, 21.5, 22.5, 24, 25, 27.5, 28.5, 31, 34, 36.5, 45),
    Men = c(1.3, 1.2, 1.1, 1.0, 1.0, 1.0, 1.1, 1.3, 1.25, 1.7, 2.1, 2.7), 
    Women = c(1.4, 1.1, 1.0, 1.0, 1.0, 1.0, 1.1, 1.15, 1.25, 1.4, 1.65, 1.7))

my_data_long <- melt(my_data, id = "bmi",
                     variable.name = "gender", value.name = "rrod")

p <- ggplot(my_data_long, aes(x = bmi, y = rrod)) +
  geom_line(aes(linetype = gender)) +
  geom_point(aes(shape = gender)) +
  scale_linetype_manual(values=c("Men" = "solid", "Women" = "longdash")) +
  scale_shape_manual(values = c("Men" = 16, "Women" = 15)) + 
  scale_x_continuous(breaks = seq(15, 50, 5), limits = c(15, 50), 
                     expand = c(0, 0)) + 
  scale_y_continuous(breaks = seq(0.6, 3.2, 0.2), limits = c(0.6, 3.2), 
                     expand = c(0, 0)) +
  labs(x = "Body-Mass Index, Midpt", y = "Relative Risk of Death") +
  ggtitle(expression(
    atop(bold("Fig 7.30 Body Mass Index: Corrected"),
         atop(bold("Nonsmokers with No History of Disease"))))) +   
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"),
        legend.position = c(0.25, 0.5), # relative to plot region
        legend.title = element_blank(),
        legend.key = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## note: my_data is estimated

