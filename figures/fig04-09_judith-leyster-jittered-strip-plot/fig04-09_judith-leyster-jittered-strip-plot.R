library(ggplot2)

this_base <- "fig04-09_judith-leyster-jittered-strip-plot"

my_data <- data.frame(
  minutes <- c(4, 7, 7, 9, 10, 10, 11,
               11, 13, 14, 15, 15, 20, 21,
               22, 22, 23, 27, 27, 28, 28,
               29, 31, 32, 33, 33, 35, 38,
               38, 39, 40, 40, 40, 40, 42,
               42, 42, 43, 45, 47, 48, 48,
               49, 49, 55, 58, 66, 72, 73)
)

summ_stats <-
  with(my_data,
       data.frame(stat = c("Mean", "Median", "Quartile", "Quartile"),
                  val = c(mean(minutes), median(minutes),
                          quantile(minutes, probs = c(0.25, 0.75)))))

# to reproduce jittering
set.seed(0)

p <- ggplot(my_data, aes(x = minutes, y = factor(1))) +
  geom_point(shape = 1, position = position_jitter(w = 0.02, h = 0.02)) +
  scale_x_continuous(breaks = c(20, 40, 60), limits = c(0, 80), 
                     expand = c(0, 0)) +
  labs(x = "Minutes", y = NULL) +
  ggtitle("Fig 4.9 Judith Leyster Exhibition: Jittered Strip Plot") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = rel(1.2), face = "bold"),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "top",
        legend.title = element_blank())

p <- p + geom_vline(data = summ_stats, aes(xintercept = val, linetype = stat), 
                    show_guide = TRUE)

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 3)

## TODO: fix legend to match original


