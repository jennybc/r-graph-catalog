library(ggplot2)
library(gridExtra)
library(reshape2)

this_base <- "fig08-09_arl-library-survey-variation-of-a-trellis-plot"

my_data <- read.delim(paste0(this_base, ".tsv"))

my_data$labels <- with(my_data, paste0(Abbreviation, "(", Number, ")"))

# create variables for interval
my_data <- transform(my_data, RGap = Desired - Perceived)
names(my_data)[names(my_data) == "Gap"] <- "LGap"

my_data_long <- 
  melt(my_data, id.vars = c("Number", "Question", "Abbreviation", "Group", 
                            "LGap", "RGap", "labels"), 
       variable.name = "Type", value.name = "Score")

my_data_long[which(my_data_long$Type %in% c("Minimum", "Desired")), 
             c("RGap", "LGap")] <- 0

my_data_1 <- subset(my_data_long, Group == "Access to Information")
my_data_1$labels <- 
  factor(my_data_1$labels, c("Interdisciplinary(9)", "Print.Collections(22)",
                             "Delivery(8)", "Hours(19)", "Journals(3)"))

my_data_2 <- subset(my_data_long, Group == "Personal Control")
my_data_2$labels <- 
  factor(my_data_2$labels, 
         c("Equipment(6)", "Convenient(25)", "Accessible.info(16)",
           "Access.tools(12)", "Home/office(5)", "Website(7)"))

my_data_3 <- subset(my_data_long, Group == "Library as Place")
my_data_3$labels <- 
  factor(my_data_3$labels, 
         c("Reflection(13)", "Contemplative(23)", 
           "Quiet.haven(10)", "Quiet(2)", "Comfortable(21)"))

my_data_4 <- subset(my_data_long, Group == "Affect of Service")
my_data_4$labels <- 
  factor(my_data_4$labels, 
         c("Instill.confidence(20)", "Attentive(14)", "Caring(15)", 
           "Helpful(1)", "Understanding(24)", "Dependable(11)", 
           "Courteous(4)", "Responsive(18)", "Knowledgeable(17)"))

makePlot <- function(dat) {
  ggplot(dat, aes(x = Score, y = labels, shape = Type)) +
    geom_point(show_guide = FALSE) +
    scale_shape_manual(values = c(124, 124, 4)) +
    geom_segment(aes(x = Score - LGap, xend = Score + RGap,
                     y = labels, yend = labels)) +
    scale_x_continuous(breaks = c(5, 6, 7, 8), limits = c(4, 9), 
                       expand = c(0, 0)) +
    labs(x = "score", y = NULL) +
    facet_grid(~ Group) +
    theme_bw() +
    theme(panel.grid.major.y = element_line(colour = "black", 
                                            linetype = "dotted"),
          panel.grid.major.x = element_blank(),
          panel.grid.minor = element_blank(),
          axis.ticks.y = element_blank())
}

p1 <- makePlot(my_data_1)
p2 <- makePlot(my_data_2)
p3 <- makePlot(my_data_3)
p4 <- makePlot(my_data_4)

p5 <- arrangeGrob(
  p1, p2, p3, p4, nrow = 2,
  main = textGrob("Fig 8.9 ARL Library Survey: Variation\nof a Trellis Plot",
                  just = "top", vjust = 0.75, gp = gpar(fontface = "bold")),
  sub = textGrob("Line Segments from Minimum to Desired    X Perceived"))

p5

ggsave(paste0(this_base, ".png"), 
       p5, width = 8, height = 7)

## pedantic: y axis for right side plots not on right side, cant get 
## graphs to stack together
