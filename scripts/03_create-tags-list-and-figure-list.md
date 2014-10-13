

```r
library(plyr)

## Generate figures list and corresponding tags list

# get list of fig directories
basenames <- list.files(file.path(PROJHOME, "figures"))

# get tags files
fig_tags_files <- list.files(file.path(PROJHOME, "figures", basenames),
                             pattern = "_tags.txt$", full.names = TRUE)

names(fig_tags_files) <- basenames

fig_tags <- ldply(as.list(fig_tags_files), function(x) {
  tags_pre <- scan(x, character(), sep = ",", quiet = TRUE)
  tags_post <- paste(tags_pre, collapse=",")
  data.frame(tags = I(tags_post))
})

fig_tags <- rename(fig_tags, c(".id" = "basename"))

# remove figures that we arent doing from the figure list
fig_tags <- fig_tags[-grep("not doing", fig_tags$tags),]


## Generate tags list

all_tags <- unique(unlist(strsplit(fig_tags$tags, split = ",")))

# chapter tags
ind_chap <- grep(paste0("ch", "[[:digit:]][[:digit:]]", "_"), all_tags)
tags_chap <- all_tags[ind_chap]

# type tags
to_match <- c("good", "bad", "not recommended")
ind_type <- unique(grep(paste(to_match, collapse = "|"), all_tags))
tags_type <- all_tags[ind_type]


to_match_graph_elem <- c("annotation", "footnote", "multiple plots",
                         "data labels", "loess smoothing", "jitter",
                         "legend", "subscript")

ind_graph_elem <- unique(grep(paste(to_match_graph_elem, collapse = "|"), all_tags))
tags_graph_elem <- all_tags[ind_graph_elem]

# chart type tags
tags_other <- all_tags[-c(ind_chap, ind_type, ind_graph_elem)]

tags_other <- tags_other[-which(tags_other == "naomi")]

tags_only <- data.frame(c("===GRAPH TYPE===", tags_type, "===GRAPH TAGS===",
                          tags_other, "===GRAPH ELEMENTS===", tags_graph_elem,
                          "===CHAPTER===", tags_chap))

names(tags_only) <- "List of all tags"

tags_only
```

```
##             List of all tags
## 1           ===GRAPH TYPE===
## 2                       good
## 3            not recommended
## 4           ===GRAPH TAGS===
## 5                      other
## 6                scatterplot
## 7                  pie chart
## 8                   dot plot
## 9                      table
## 10                 bar chart
## 11                line graph
## 12              bubble chart
## 13                 stripplot
## 14                 histogram
## 15                   boxplot
## 16                timeseries
## 17                month plot
## 18           trellis display
## 19              spline graph
## 20               mosaic plot
## 21 parallel coordinates plot
## 22                 rose plot
## 23                 area plot
## 24              waffle chart
## 25      ===GRAPH ELEMENTS===
## 26                    legend
## 27                annotation
## 28            multiple plots
## 29                    jitter
## 30           loess smoothing
## 31               data labels
## 32                 subscript
## 33                  footnote
## 34             ===CHAPTER===
## 35                ch01_intro
## 36          ch02_limitations
## 37           ch03_perception
## 38              ch04_1or2dim
## 39         ch05_morethan2var
## 40              ch06_general
## 41               ch07_scales
## 42          ch08_beforeafter
## 43             ch09_software
## 44                ch10_qanda
```

```r
head(fig_tags)
```

```
##                                basename
## 1 0002_add-background-with-cats-package
## 2           fig01-01_similar-pie-wedges
## 3  fig01-02_similar-pie-wedges-dot-plot
## 4     fig01-03_similar-pie-wedges-table
## 5          fig02-01_structured-data-set
## 6 fig02-02_structured-data-set-dot-plot
##                                               tags
## 1                           other,scatterplot,good
## 2       pie chart,ch01_intro,naomi,not recommended
## 3                   dot plot,good,ch01_intro,naomi
## 4                      table,good,ch01_intro,naomi
## 5 pie chart,ch02_limitations,naomi,not recommended
## 6             dot plot,good,ch02_limitations,naomi
```

```r
out_dir <- file.path(PROJHOME, "r-graph-catalog", "data")
if(!file.exists(out_dir)) {
	dir.create(out_dir)
}

## Save to file

write.table(tags_only,
            file.path(PROJHOME, "outputs", "available-tags.tsv"),
            sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)

write.table(fig_tags,
            file.path(out_dir, "figure-list.tsv"),
            sep = '\t', row.names = FALSE, quote = FALSE)
```


---
title: "03_create-tags-list-and-figure-list.R"
author: "jenny"
date: "Sun Oct 12 18:10:44 2014"
---
