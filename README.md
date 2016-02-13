# minimap

## Inspiration

- [The New York Times](http://www.nytimes.com/interactive/2015/03/04/us/gay-marriage-state-by-state.html)
- [The Washington Post](https://www.washingtonpost.com/graphics/national/minimum-wage/)
- [NPR](http://blog.apps.npr.org/2015/05/11/hex-tile-maps.html)

## Install

```r
library(devtools)
install_github("seankross/minimap")
```

## Demo

```r
library(minimap)

# Demo 1

miniusa(c(state.abb, "DC"), 1:51)

# Demo 2

determine_color <- function(status){
  if(status == "bbs")
    "#FFE597"
  else if(status == "nl")
    "#F1F1F0"
  else if (status == "dis")
    "#D0C7B9"
  else if(status == "bbca")
    "#FDC471"
  else
    "#817972"
}

ssm$color <- as.character(sapply(ssm$status, determine_color))
ssm_2008 <- ssm[ssm$year == 2008,]
miniusa(ssm_2008$state, state_colors = ssm_2008$color, state_names = TRUE,
        state_name_colors = rep("white", 51), state_name_cex = .7)
title(main = "2008", line = -1)

# Demo 3

par(xaxs = "r", yaxs = "r")
par(mai = c(0, 0, .75, .5), mfrow = c(2, 4), cex = 1)

for(i in 2008:2015){
  one_year <- ssm[ssm$year == i,]
  miniusa(one_year$state, state_colors = one_year$color, state_names = FALSE)
  title(main = i, line = -2)
}

mtext("Legal Status of Gay Marriage Over Time", outer = TRUE, side = 3, line = -2)
```
