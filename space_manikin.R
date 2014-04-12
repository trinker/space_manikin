## ----setup, include=FALSE------------------------------------------------
# set global chunk options
library(pacman); p_load(knitr, RWordPress, xtable, reports, knitcitations, animation)
opts_chunk$set(cache = TRUE, warning = FALSE)
bib <- read.bibtex(dir()[tools::file_ext(dir()) == "bib"][1])


pressNum_n_dir <- "61803503/wp/"
path2figureStorage <- "C:/Users/trinker/Dropbox/Public/wp/"
opts_knit$set(base.url = paste0("http://dl.dropboxusercontent.com/u/", pressNum_n_dir),
    base.dir = path2figureStorage)
opts_chunk$set(cache = TRUE, warning = FALSE, message = FALSE, tidy=FALSE)
library(knitr)


## ------------------------------------------------------------------------
library(maps); library(ggplot2)
head(map_data("state"))


## ----, results='hide', fig.height=4.5, fig.width=4.5---------------------
library(png); library(grid); library(qdap)
url_dl(url="http://i.imgur.com/eZ76jcu.png")
file.rename("eZ76jcu.png", "body.png")
img <- rasterGrob(readPNG("body.png"), 0, 0, 1, 1, just=c("left","bottom"))
ggplot(data.frame(x=c(0, 1), y=c(0, 1)), aes(x=x, y=y)) + 
	geom_point() +
	annotation_custom(img, 0, 1, 0, 1) + 
	scale_x_continuous(breaks=seq(0, 1, by=.05))+ 
	scale_y_continuous(breaks=seq(0, 1, by=.05)) + theme_bw() +
	theme(axis.text.x=element_text(angle = 90, hjust = 0, vjust=0))


## ------------------------------------------------------------------------
library(qdap)
dat <- list(
    `01`=data.frame(x=c(.4, .4, .6, .6), y=c(.67, .525, .525, .67)),
    `02`=data.frame(x=c(.35, .4, .6, .65), y=c(.75, .67, .67, .75)),
    `03`=data.frame(x=c(.6, .65, .65, .6), y=c(.525, .475, .75, .67)),
    `04`=data.frame(x=c(.4, .35, .65, .6), y=c(.525, .475, .475, .525)),
    `05`=data.frame(x=c(.35, .35, .4, .4), y=c(.75, .475, .525, .67)),
    `06`=data.frame(x=c(.4, .4, .6, .6), y=c(.87, .75, .75, .87)),
    `07`=data.frame(x=c(.6, .6, .65, .65, .73, .73), y=c(.87, .75, .75, .67, .67, .87)),
    `08`=data.frame(x=c(.65, .65, .73, .73), y=c(.67, .525, .525, .67)),
    `09`=data.frame(x=c(.6, .6, .73, .73, .65, .65), y=c(.475, .28, .28, .525, .525, .475)),
    `10`=data.frame(x=c(.4, .4, .6, .6), y=c(.475, .28, .28, .475)),
    `11`=data.frame(x=c(.27, .27, .4, .4, .35, .35), y=c(.525, .28, .28, .475, .475, .525)),
    `12`=data.frame(x=c(.27, .27, .35, .35), y=c(.67, .525, .525, .67)),
    `13`=data.frame(x=c(.27, .27, .35, .35, .4, .4), y=c(.87, .67, .67, .75, .75, .87)),
    `14`=data.frame(x=c(.35, .35, .65, .65), y=c(1, .87, .87, 1)),
    `15`=data.frame(x=c(.65, .65, .73, .73, 1, 1), y=c(1, .87, .87, .75, .75, 1)),
    `16`=data.frame(x=c(.73, .73, 1, 1), y=c(.75, .475, .475, .75)),
    `17`=data.frame(x=c(.65, .65, 1, 1, .73, .73), y=c(.28, 0, 0, .475, .475, .28)),
    `18`=data.frame(x=c(.35, .35, .65, .65), y=c(.28, 0, 0, .28)),
    `19`=data.frame(x=c(0, 0, .35, .35, .27, .27), y=c(.475, 0, 0, .28, .28, .475)),
    `20`=data.frame(x=c(0, 0, .27, .27), y=c(.75, .475, .475, .75)),
    `21`=data.frame(x=c(0, 0, .27, .27, .35, .35), y=c(1, .75, .75, .87, .87, 1))
)

dat <- lapply(dat, function(x) {
    x$order <- 1:nrow(x)
    x
})

space.manikin.shape <- list_df2df(dat, "id")[, c(2, 3, 1, 4)]


## ------------------------------------------------------------------------
centers <- data.frame(
    id = unique(space.manikin.shape$id),
    center.x=c(.5, .5, .625, .5, .375, .5, .66, .69, .66, .5, .34, .31, 
        .34, .5, .79, .815, .79, .5, .16, .135, .16),
    center.y=c(.597, .71, .5975, .5, .5975, .82, .81, .5975, .39, .3775, .39, 
        .5975, .81, .935, .89, .6025, .19, .14, .19, .6025, .89)
)



## ----, fig.width=4.5, fig.height=4.5-------------------------------------
ggplot(centers) + annotation_custom(img,0,1,0,1) +
    geom_map(aes(map_id = id), map = space.manikin.shape, colour="black", fill=NA) +
    theme_bw()+ 
    expand_limits(space.manikin.shape) +
    geom_text(data=centers, aes(center.x, center.y, label = id), color="grey60") 


## ----, fig.width=4.5, fig.height=4.5-------------------------------------
img[["raster"]][img[["raster"]] == "#0E0F0FFF"] <- "#E7E7E7"

ggplot(centers) + annotation_custom(img,0,1,0,1) +
    geom_map(aes(map_id = id), map = space.manikin.shape, colour="black", fill=NA) +
    theme_bw()+ 
    expand_limits(space.manikin.shape) +
    geom_text(data=centers, aes(center.x, center.y, label = id), color="grey60") 


## ----, fig.width=4.5, fig.height=4.5, results='hide'---------------------
browseURL("https://github.com/trinker/space_manikin/raw/master/images/being.ps")
## Move that file from your downloads to your working directoy.
## Sorry I don't know how to automate this.
library(grImport)

## Convert to xml
PostScriptTrace("being.ps")

## Read back in and convert to a grob
being_img <- pictureGrob(readPicture("being.ps.xml"))

## Plot it
ggplot(centers) + annotation_custom(being_img,0,1,0,1) +
    geom_map(aes(map_id = id), map = space.manikin.shape, 
    	colour="black", fill=NA) +
    theme_bw()+ 
    expand_limits(space.manikin.shape) +
    geom_text(data=centers, aes(center.x, center.y, 
    	label = id), color="grey60") 


## ----, fig.width=4.5, fig.height=4.5-------------------------------------
being_img[["children"]][[1]][[c("gp", "fill")]] <- 
  being_img[["children"]][[2]][[c("gp", "fill")]] <- "black"

being_img[["children"]][[1]][[c("gp", "alpha")]] <- 
  being_img[["children"]][[2]][[c("gp", "alpha")]] <- .2

## Plot it
ggplot(centers) + annotation_custom(being_img,0,1,0,1) +
    geom_map(aes(map_id = id), map = space.manikin.shape, 
    	colour="black", fill=NA) +
    theme_bw()+ 
    expand_limits(space.manikin.shape) +
    geom_text(data=centers, aes(center.x, center.y, 
    	label = id), color="grey60") 


## ----, fig.width=6.5, fig.height=5---------------------------------------
set.seed(10)
centers[, "Frequency"] <- rnorm(nrow(centers))
	
being_img[["children"]][[1]][[c("gp", "alpha")]] <- 
  being_img[["children"]][[2]][[c("gp", "alpha")]] <- .25

ggplot(centers, aes(fill=Frequency)) +
    geom_map(aes(map_id = id), map = space.manikin.shape, 
    	colour="black") +
	scale_fill_gradient2(high="red", low="blue") +
    theme_bw()+ 
    expand_limits(space.manikin.shape) +
    geom_text(data=centers, aes(center.x, center.y, 
    	label = id), color="black") + 
	annotation_custom(being_img,0,1,0,1) 


## ----, fig.width=6.5, fig.height=5---------------------------------------
set.seed(10)
centers[, "Frequency2"] <- sample(seq(10, 150, by=20, ), nrow(centers), TRUE)

centers2 <- centers[rep(1:nrow(centers), centers[, "Frequency2"]), ]

ggplot(centers2) +
#	    geom_map(aes(map_id = id), map = space.manikin.shape, 
#    	colour="grey65", fill="white") +
    stat_density2d(data = centers2, 
        aes(x=center.x, y=center.y, alpha=..level.., 
        fill=..level..), size=2, bins=12, geom="polygon") + 
    scale_fill_gradient(low = "yellow", high = "red") +
    scale_alpha(range = c(0.00, 0.5), guide = FALSE) +
    theme_bw()+ 
    expand_limits(space.manikin.shape) +
    geom_text(data=centers, aes(center.x, center.y, 
    	label = id), color="black") + 
	annotation_custom(being_img,0,1,0,1) +
    geom_density2d(data = centers2, aes(x=center.x, 
        y=center.y), colour="black", bins=8, show_guide=FALSE) 


## ----, echo=FALSE, results='asis'----------------------------------------
bibliography("html")


## ----, echo=FALSE, results="hide"----------------------------------------
knitr::purl("space_manikin.Rmd")


