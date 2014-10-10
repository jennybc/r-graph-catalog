library(ggplot2)
library(gridExtra) #arrangeGrob

this_base <- "fig06-30_health-insurance-data"

who_pays <- c("Private out-of-pocket","Private health insurance and other", 
              "Medicaid", "Medicare", "Other government insurance")

my_data <- data.frame(
  who_pays = factor(who_pays, who_pays),
  percentage = c(19, 36, 22, 15, 8))

y_breaks <- cumsum(my_data$percentage) - my_data$percentage/2
y_labels <- c("Private out-of-\npocket", "Private\nhealth insurance\nand other",
              "Medicaid", "Medicare", "Other government\ninsurance")

y_percentage = c(19, 36, 15, 22, 8)

p1 <- ggplot(my_data, aes(x = factor(1), y = percentage, fill = who_pays)) +
  geom_bar(width = 1, colour = "black", stat = "identity") + 
  guides(fill = FALSE) + 
  geom_text(aes(x = 1.70, y = y_breaks,
                label = y_labels, hjust = c(0, 0, NA, NA, 1)), size = 2.5) +
  geom_text(aes(x = 1.2, y = y_breaks, label = paste0(y_percentage, "%")), 
            size = 3, , colour = "white") + 
  coord_polar(theta = "y") +
  scale_fill_manual(values = c("grey60", "grey70", "grey30", "grey40", "grey50")) +
  theme_bw() + 
  theme(panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.border = element_blank(),
        plot.margin = unit(c(0, 0, -0.5, 0),"cm"),
        axis.title = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank())

p2 <- ggplot(my_data, aes(x = factor(1), y = percentage)) +
  geom_bar(width = 1, colour = "black", stat = "identity", fill = "white") + 
  guides(fill = FALSE) + 
  geom_text(aes(x = 1.70, y = y_breaks,
                label = y_labels, hjust = c(0, 0, NA, NA, 1)), size = 2.5) +
  geom_text(aes(x = 1.2, y = y_breaks,
                label = paste0(percentage, "%")), size = 3) +
  coord_polar(theta = "y") +
  theme_bw() + 
  theme(panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.border = element_blank(),
        plot.margin = unit(c(-0.5, 0, 0, 0), "cm"),
        axis.title = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank())

text <- paste("Who pays?\nOf all industrialized\ncountries, the U.S.\n",
              "has the lowest\npercentage of population\n", 
              "with government-assured\nhealth insurance.")

# arrange plots together 
p3 <- arrangeGrob(
  p1, p2, nrow = 2,
  main = textGrob("Fig 6.30 Health Insurance Data", 
                  just = "top", vjust = 0.75, 
                  gp = gpar(fontsize = 14, fontface = "bold")),
  legend = textGrob(text, hjust = 1.1, vjust = -0.75, gp = gpar(fontsize = 10)))

p3

ggsave(paste0(this_base, ".png"), p3, width = 7, height = 7)

## pedantic: bold title of text to side and left alignment

