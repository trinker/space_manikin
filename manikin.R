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

## add order

centers <- data.frame(
    id = unique(space.manikin.shape$id),
    center.x=c(.5, .5, .625, .5, .375, .5, .66, .69, .66, .5, .34, .31, 
        .34, .5, .79, .815, .79, .5, .16, .135, .16),
    center.y=c(.597, .71, .5975, .5, .5975, .82, .81, .5975, .39, .3775, .39, 
        .5975, .81, .935, .89, .6025, .19, .14, .19, .6025, .89)
)

merge(space.manikin.shape, centers)[, c(2:3, 1, 4:6)]

library(png)

img[["raster"]][128, 128]

img <- rasterGrob(readPNG("body.png"),0,0,1,1,just=c("left","bottom"))
img[["raster"]][img[["raster"]] == "#0E0F0FFF"] <- "#E7E7E7"

ggplot(centers) + annotation_custom(img,0,1,0,1) +
    geom_map(aes(map_id = id), map = space.manikin.shape, colour="black", fill=NA) +
    theme_bw()+ 
    expand_limits(space.manikin.shape) +
    geom_text(data=centers, aes(center.x, center.y, label = id), color="grey60") 



p_load(grImport)

PostScriptTrace("being.ps")

beingRGML <- readLines("being.ps.xml")
being <- readPicture("being.ps.xml")

str(being)

being@paths[[2]]@rgb <- being@paths[[1]]@rgb <- "#D0D0D0"
being_img <- pictureGrob(being)

saveRDS(being_img, file="being.rds")

being_img[["children"]][[1]][[c("gp", "fill")]] <- 
  being_img[["children"]][[2]][[c("gp", "fill")]] <- "black"

being_img[["children"]][[1]][[c("gp", "alpha")]] <- 
  being_img[["children"]][[2]][[c("gp", "alpha")]] <- .2


ggplot(centers) + annotation_custom(being_img,0,1,0,1) +
    geom_map(aes(map_id = id), map = space.manikin.shape, colour="black", fill=NA) +
    theme_bw()+ 
    expand_limits(space.manikin.shape) +
    geom_text(data=centers, aes(center.x, center.y, label = id), color="grey60") 


being <- gsub("<rgb.+$",
"<rgb r='0.3' g='0.6' b='0.8'/>",
beingRGML)
writeLines(being, "being.ps.xml")

gpar(being_img)

## put the .rds file in as a system file that can be accessed from the function
## put the space.manikin.shape and centers into the space_manikin.R file using dput2
## the figure has color set via...
## 
## being_img[["children"]][[1]][[c("gp", "fill")]] <- 
##   being_img[["children"]][[2]][[c("gp", "fill")]] <- "blue"
##
## And can be excluded from the plot
## look at altering transparency



