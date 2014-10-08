library(plyr)

## get top-level directory for this project
proj_dir <-
  normalizePath(if(basename(getwd()) == "scripts") ".." else getwd())

## Generate figures list and corresponding tags list

# get list of fig directories
basenames <- list.files(file.path(proj_dir, "figures"))

# get tags files
fig_tags_files <- list.files(file.path(proj_dir, "figures", basenames),
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

head(fig_tags)

## Save to file

write.table(tags_only,
            file.path(proj_dir, "outputs", "available-tags.tsv"),
            sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)

write.table(fig_tags,
            file.path(proj_dir, "r-graph-catalog", "data", "figure-list.tsv"),
            sep = '\t', row.names = FALSE, quote = FALSE)
