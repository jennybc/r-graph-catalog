library(ggplot2)
library(reshape2)
library(gridExtra)

this_base <- "fig07-29_body-mass-data-comparing-panels"

my_data_men <- 
  data.frame(
    bmi = c("<18.5", "18.5-20.4", "20.5-21.9", "22.0-23.4", "23.5-24.9",
            "25.0-26.4", "26.5-27.9", "28.0-29.9", "30.0-31.9", "32.0-34.9",
            "35.0-39.9", ">=40.0"),
    cfs_hd = c(1.78, 1.57, 1.30, 1.21, 1.0, 0.95, 
               0.90, 1.0, 1.0, 1.1, 1.15, 1.4),
    cfs_nhd = c(1.55, 1.35, 1.20, 1.1, 1.0, 1.05, 
                1.0, 1.0, 1.2, 1.25, 1.35, 1.8),
    ns_hd = c(1.45, 1.5, 1.2, 1.1, 1.0, 1.0, 1.0, 
              1.1, 1.2, 1.25, 1.4, 1.5),
    ns_nhd = c(1.3, 1.2, 1.1, 1.0, 1.0, 1.0, 1.1, 
               1.3, 1.25, 1.7, 2.1, 2.7) 
  )

my_data_women <- 
  data.frame(
    bmi = c("<18.5", "18.5-20.4", "20.5-21.9", "22.0-23.4", "23.5-24.9",
            "25.0-26.4", "26.5-27.9", "28.0-29.9", "30.0-31.9", "32.0-34.9",
            "35.0-39.9", ">=40.0"), 
    cfs_hd = c(2.07, 1.32, 1.17, 1.1, 1.0, 1.1, 
               1.12, 1.12, 1.15, 1.15, 1.15, 1.4),
    cfs_nhd = c(1.82, 1.2, 1.06, 1.04, 1.0, 1.1, 
                1.11, 1.15, 1.25, 1.26, 1.45, 1.5),
    ns_hd = c(1.55, 1.17, 1.07, 1.06, 1.0, 1.1, 
              1.1, 1.15, 1.15, 1.2, 1.3, 1.5),
    ns_nhd = c(1.4, 1.1, 1.0, 1.0, 1.0, 1.0, 1.1, 
               1.15, 1.25, 1.4, 1.65, 1.7))

my_data_men$bmi <- 
  factor(my_data_men$bmi, 
         levels =  c("<18.5", "18.5-20.4", "20.5-21.9", "22.0-23.4", 
                     "23.5-24.9", "25.0-26.4", "26.5-27.9", "28.0-29.9", 
                     "30.0-31.9", "32.0-34.9", "35.0-39.9", ">=40.0"))

my_data_women$bmi <- 
  factor(my_data_men$bmi, 
         levels =  c("<18.5", "18.5-20.4", "20.5-21.9", "22.0-23.4", 
                     "23.5-24.9", "25.0-26.4", "26.5-27.9", "28.0-29.9", 
                     "30.0-31.9", "32.0-34.9", "35.0-39.9", ">=40.0"))

my_data_men_long <- melt(my_data_men, "bmi")
my_data_women_long <- melt(my_data_women, "bmi")

legend_labs = c("Current or former smokers\n with a history of disease",
                "Current or former smokers\n with no history of disease",
                "Nonsmokers with a history of disease",
                "Nonsmokers with no history of disease")

p1 <- ggplot(my_data_men_long, aes(x = bmi, y = value, group = variable)) +
  geom_line(aes(linetype = variable)) +
  annotate("text", x = 1.5, y = 2.9, size = 4, label = "Men") +
  scale_linetype_manual(values = c("dotted", "longdash", "solid", "solid"),
                        labels = legend_labs) + 
  scale_y_continuous(breaks = seq(0.6, 2.8, 0.2), limits = c(0.6, 3.0), 
                     expand = c(0, 0)) +
  labs(x = "Body-Mass Index", y = "Relative Risk of Death") +
  theme_classic() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.text.x = element_text(angle = 45, vjust = 0.5),
        legend.position = c(0.3, 0.7), # relative to plot region
        legend.title = element_blank(),
        legend.key = element_blank())

p2 <- ggplot(my_data_women_long, aes(x = bmi, y = value, group = variable)) +
  geom_line(aes(linetype = variable), show_guide = FALSE) +
  annotate("text", x = 1.5, y = 2.3, size = 4, label = "Women") +
  scale_linetype_manual(values = c("dotted", "longdash", "solid", "solid")) + 
  scale_y_continuous(breaks = seq(0.8, 2.2, 0.2), limits = c(0.8, 2.4), 
                     expand = c(0, 0)) +
  labs(x = "Body-Mass Index", y = "Relative Risk of Death") +
  theme_classic() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        axis.text.x = element_text(angle = 45, vjust = 0.5))


# arrange plots together 
p3 <- arrangeGrob(p1, p2, nrow = 2,
                  main = textGrob("Fig 7.29 Body Mass Data: Comparing Panels", 
                                  just = "top", vjust = 0.75, 
                                  gp = gpar(fontsize = 14, lineheight = 1, 
                                            fontface = "bold")))

p3


ggsave(paste0(this_base, ".png"), p3, width = 6, height = 9)

## note: my_data is estimated

