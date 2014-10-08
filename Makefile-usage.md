Makefile Usage
========================================================

Targets:
---
#### Initialize a new figure directory:

* `init`
	- initialize a new figure directory with `*.R`, `README-fodder.md`, `*_tags.txt`

#### Update everything:
* `all`
	- dependencies: `pngs` `thumbs` `readmes` `basenames` `lists` `copy-files`

##### Update individual dependencies of `all`
* `pngs`
	- dependency: `*.R`
	- source `.R` files to create the pngs

* `thumbs`
	- dependency: `*.png`
	- generate thumbnail (`*_thumb.png`) for every `*.png`

* `readmes`
	- dependencies: `cmeg-readmes`  `other-readmes`
	- generate `README.md` for each figure directory
		- `cmeg-readmes` are specific to CMEG figures and will use information from appendix-b.tsv
		- `other-readmes` are general

* `basenames`
	- dependency: `appendix-b.tsv`
	- generate `appendix-b-with-basenames.tsv` used for naming CMEG figure directories


#### r-graph-catalog:

#####Prepare files for r-graph-catalog:
* `lists`
	- dependencies: `available-tags.tsv` `figure-list.tsv`
	- generate tags list and figure list for r-graph-catalog app

#####Copy files to r-graph-catalog
* `copy-files`
		- copy all R code, pngs, thumbnails and figure list


#### For maintenance:
* `check-basenames`
	- check if hardcoded basenames match name of figure directory

* `check-directories`
	- check which directories are CMEG and which are not

Variables (scripts used):
---
	script01 = `01_create-filenames-for-figures.R`
	script02 = `02_create-figure-directories.R`
	script03 = `01_create-thumbnail.R`
	script04 = `02_generate-readme.R`
	script05 = `03_generate-readme-with-appendix-b.R`
	script06 = `03_create-tags-list-and-figure-list.R`
	script07 = `04_copy-files-into-r-graph-catalog.R`
	script08 = `00_init-figure-directory.R`
	script09 = `12_check-hardcoded-basenames.R`
	script10 = `13_manage-figure-directories.R`

