library(ggplot2)
library(grid)

this_base <- "fig10-03_presidential-approval-data-waffle-chart"

my_data <- data.frame(decision = c("Approve", "Disapprove", "No Opinion"),
                      ncases = c(53L, 34L, 13L))

# number of rows for y axis
ndeep <- 10

# Specify unique x and y coord for each case
# One y for each row; then divide the total number of cases by the number of
# rows and round up to get the appropriate number of x increments
my_data_waffle <- expand.grid(y = 1:ndeep,
                              x = seq_len(ceiling(sum(my_data$ncases) / ndeep)))

# Expand the counts into a full vector of labels
decisionvec <- rep(my_data$decision, my_data$ncases)

# Depending on the value of ndeep, there might be more spots on the x-y grid
# than there are cases - so fill those with NA
my_data_waffle$decision <- 
  c(decisionvec, rep(NA, nrow(my_data_waffle) - length(decisionvec)))

my_data_waffle$decision <- factor(my_data_waffle$decision)

p <- ggplot(my_data_waffle, aes(x = x, y = y, fill = decision)) + 
  geom_tile(color = "black", size = 0.5) +
  geom_hline(aes(yintercept = 5.5), size = 2) +
  geom_vline(aes(xintercept = 5.5), size = 2) +
  scale_fill_manual(breaks = c("1", "2"), 
                    values = c("grey30", "grey60", "white"),
                    labels = c("Approve", "Disapprove")) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0), trans = 'reverse') +
  ggtitle("Fig 10.3 Presidential Approval Data \nWaffle Chart") +
  theme(panel.border = element_rect(fill = NA, size = 3),
        plot.title = element_text(size = rel(1.2), face = "bold"),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        legend.title = element_blank(),
        legend.position = "bottom",
        legend.direction = "vertical")

p

ggsave(paste0(this_base, ".png"), p, width = 5, height = 6)

## pedantic: line in legend key, order of shaded squares doesn't match entirely
## note: Referred to http://www.techques.com/question/
##                      17-17842/How-to-make-waffle-charts-in-R 
##       for guidelines on how to create chart

