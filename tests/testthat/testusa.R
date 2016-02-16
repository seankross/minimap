library(png)
context("Test miniusa()")


path <- tempdir()
oldwd <- getwd()
old_device <- options()$device
masters <- system.file(file.path("images", paste0("usa", 1:3, ".png")), 
                       package = "minimap")
options(device = function() png(width = 480, height = 480, units = "px", 
                                pointsize = 12, bg = "white"))

setwd(path)
dir.create("usa_test")
setwd("usa_test")

miniusa(usa_abb, 1:51)
dev.off()

test_that("The USA is drawn correctly 1", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[1]))
})

miniusa(usa_abb, 1:51, border_colors = rep("red", 51), 
           state_names = FALSE)
dev.off()

test_that("The USA is drawn correctly 2", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[2]))
})

miniusa(usa_abb, rep("black", 51), border_colors = rep("white", 51), 
           state_name_colors = rep("yellow", 51), state_name_cex = .5, 
           font = "serif")
dev.off()

test_that("The USA is drawn correctly 3", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[3]))
})

setwd(path)

test_that("miniusa() throws appropriate errors", {
  expect_error(miniusa(usa_abb[1:10], 1:51))
  expect_error(miniusa(usa_abb, 1:10))
  expect_error(miniusa(usa_abb, 1:51, border_colors = 1:10))
  expect_error(miniusa(usa_abb, 1:51, state_names = NA))
  expect_error(miniusa(usa_abb, 1:51, state_name_colors = 1:10))
})

unlink("usa_test", recursive = TRUE, force = TRUE)
setwd(oldwd)
options(device = old_device)
