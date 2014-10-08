## tells Make to look in these directories for target and input files
VPATH = scripts scripts/cmeg inputs outputs r-graph-catalog r-graph-catalog/data

## in future, I could take finer control like so
## vpath pattern directory-list
## examples from the compiling world:
## vpath %.c src
## vpath %.h include

## create a macro to render (i.e. spin) an R script and tidy up after
define tidy-spin
      @echo Spinning $< ...
      Rscript -e 'rmarkdown::render("$<", clean = FALSE)'
      rm $(basename $<).spin.Rmd
      rm $(basename $<).spin.R
      rm $(basename $<).knit.md
      mv $(basename $<).utf8.md $(basename $<).md
endef

## construct figure file and directory basenames from Appendix B

## phony target for convenience of user
basenames: appendix-b-with-basenames.tsv

script01 = 01_create-filenames-for-figures.R

appendix-b-with-basenames.tsv: $(script01) appendix-b.tsv
	$(tidy-spin)
	rm scripts/cmeg/01_create-filenames-for-figures.html scripts/cmeg/01_create-filenames-for-figures.md

## create the figure directories if they dont already exist
script02 = 02_create-figure-directories.R

## phony target for convenience of user
#cmeg_fig_dirs: $(basename $(script02)).md

$(basename $(script02)).md: $(script02) appendix-b-with-basenames.tsv
	$(tidy-spin)

# The default target of this Makefile
all: basenames pngs readmes thumbs lists copy-files

# all figure directories
fig_dirs = $(wildcard figures/*)

# all CMEG figure directories
cmeg_fig_dirs = $(wildcard figures/fig*)

# all other figure directories
other_fig_dirs = $(filter-out $(cmeg_fig_dirs), $(fig_dirs))

# all R files
r_files = $(wildcard figures/*/*.R)

# to create corresponding pngs for each R file
PNGS = $(patsubst %.R, %.png, $(r_files))

## phony target for all pngs
pngs: $(PNGS)

## create pngs from R files
figures/%.png: figures/%.R
	cd $(dir $<) && Rscript $(notdir $<) && rm *.pdf

script03 = 01_create-thumbnail.R

## phony target for all thumbnail pngs
thumbnails = $(patsubst %.png, %_thumb.png, $(PNGS))

# to create corresponding thumbnails for each png file
thumbs: $(thumbnails)

## generate thumbnails from pngs
%_thumb.png: %.png $(script03)
	Rscript ./scripts/$(script03) $<

script04 = 02_generate-readme.R
script05 = 03_generate-readme-with-appendix-b.R

# list of all README.mds that have to be created
readmes: cmeg-readmes other-readmes

# list of all CMEG README.mds that have to be created
cmeg-readmes: $(addsuffix /README.md , $(cmeg_fig_dirs))

# to make all CMEG README.mds
figures/fig%/README.md: figures/fig%/README-fodder.md $(script05)
	cd $(dir $<) && echo $< && Rscript ../../scripts/cmeg/$(script05) $(dir $<)

# list of all other README.mds that have to be created
other-readmes: $(addsuffix /README.md , $(other_fig_dirs))

# to make all other README.mds
%/README.md: %/*.R %/README-fodder.md $(script04)
	cd $(dir $<) && Rscript ../../scripts/$(script04) $(dir $<)

script06 = 03_create-tags-list-and-figure-list.R

lists: figure-list.tsv available-tags.tsv



# create available-tags.tsv and figure-list.tsv
figure-list.tsv available-tags.tsv: $(script06) figures/*/*_tags.txt $(PNGS)
	$(tidy-spin)

script07 = 04_copy-files-into-r-graph-catalog.R

copy-files: $(script07) figure-list.tsv
	$(tidy-spin)

script08 = 00_init-figure-directory.R

init:
	Rscript ./scripts/$(script08)

script09 = 12_check-hardcoded-basenames.R

check-basenames: $(script09) $(r_files)
	$(tidy-spin)

script10 = 13_manage-figure-directories.R

check-directories: $(script10)
	$(tidy-spin)

## Clean targets for different levels of cleaning

# clean everything - only *.R, *_tags.txt, README-fodder.md remains
clean:
	rm ./outputs/*
	rm ./figures/*/*.png
	rm ./figures/*/README.md
	rm ./r-graph-catalog/www/figures/*.png ./r-graph-catalog/www/thumbnails/*_thumb.png ./r-graph-catalog/data/*.R ./r-graph-catalog/data/figure-list.tsv

clean-figs:
	rm $(PNGS)

clean-thumbs:
	rm $(thumbnails)

clean-all-pngs:
	rm $(PNGS)
	rm $(thumbnails)

clean-readmes:
	rm ./figures/*/README.md

clean-lists:
	rm ./outputs/available-tags.tsv
	rm ./r-graph-catalog/data/figure-list.tsv

clean-r-graph-catalog:
	rm ./r-graph-catalog/data/*.R ./r-graph-catalog/data/figure-list.tsv
	rm ./r-graph-catalog/www/figures/*.png ./r-graph-catalog/www/thumbnails/*_thumb.png

