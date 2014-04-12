options(WordpressLogin = c(tylerrinker = "password"), WordpressURL = "http://trinkerrstuff.wordpress.com/xmlrpc.php")
# install.packages("RWordPress", repos = "http://www.omegahat.org/R", type = "source")

library(pacman); p_load(knitr, RWordPress)
knit2wp("space_manikin.Rmd", title = "Shape File Selfies in ggplot2")