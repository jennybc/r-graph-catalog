library(ggplot2)
library(reshape2)

this_base <- "fig07-17_income-data-gender-gap-at-all-ages"

my_data <- data.frame(age = c(19, 24, 30, 40, 50, 60, 70),
                      men = c(16, 20.2, 32, 38, 41, 37, 28.5),
                      women = c(14, 19.5, 26, 26.5, 28, 27, 20.5))

my_data_long <- melt(my_data, "age")

p <- ggplot(my_data_long, aes(x = age, y = value)) +
  geom_line(aes(linetype = variable), show_guide = FALSE) +
  geom_point(aes(size = variable), shape = 21, fill = "white", 
             show_guide = FALSE) +
  annotate("text", x = c(35, 48), y = c(37, 26), size = 4,
           label = c("Men", "Women")) +
  scale_size_manual(values = c(2, 1.5)) +
  scale_y_continuous(breaks = c(10, 20, 30, 40), limits = c(10, 45)) +
  labs(x = "Age", y = "Salary (thousands)") +
  ggtitle("Fig 7.17 Income Data: Gender Gap\nat All Ages") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5))

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)

## note: my_data is estimated

