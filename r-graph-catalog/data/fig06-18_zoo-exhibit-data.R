library(ggplot2)
library(grid)
library(scales)

this_base <- "fig06-18_zoo-exhibit-data"

my_data <- read.delim(paste0(this_base, ".tsv"))

# include newline in labels
my_data$Question <- 
  c("How Fast\nCan You Run?", "Computer", "Draw An\nAnimal", 
    "Animal\nDetective", "How Tall\nAre You?", "Oppossum", 
    "How Fast Does\nYour Heart Beat?", "Sunflower Seed\nEating Contest Macaw", 
    "Chicks and Hen", "How Far Can You Jump?", "Anaconda", 
    "Duckling\nand Mother", "Chameleon", "Llama Group\n(llama, goat,\ndonkey)")

p <- ggplot(my_data, aes(x = Percent, y = Minutes, group = Type, 
                         label = Question)) +
  geom_point(aes(shape = Type), size = 5) +
  geom_text(hjust = -0.1, vjust = -1, size = 2.5) +
  geom_hline(yintercept = 1.5, linetype = "dashed") +
  geom_vline(xintercept = 0.5, linetype = "dashed") +
  scale_shape_manual(values = c(1, 16)) +
  scale_x_continuous(breaks = seq(0.1, 1, 0.1), limits = c(0, 1), 
                     expand = c(0, 0), labels = percent) +
  scale_y_continuous(breaks = seq(0.5, 4.0, 0.5), limits = c(0, 4.5), 
                     expand = c(0, 0)) +
  labs(x = "Attractiveness (percentage of groups)",
       y = "Holding Power (duration of exhibit visits in minutes)") +
  ggtitle("Fig 6.18 Zoo Exhibit Data") +
  theme_classic() +
  theme(plot.title = element_text(size = rel(1.5), face = "bold", vjust = 1.5),
        legend.position = c(0.90, 0.10),
        legend.title = element_blank())

p

ggsave(paste0(this_base, ".png"), p, width = 7, height = 6)

## note: my_data is estimated
