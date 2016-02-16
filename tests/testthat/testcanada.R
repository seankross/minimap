library(png)
context("Test minicanada()")


path <- tempdir()
oldwd <- getwd()
old_device <- options()$device
masters <- system.file(file.path("images", paste0("canada", 1:3, ".png")), 
                       package = "minimap")
options(device = function() png(width = 480, height = 480, units = "px", 
                                pointsize = 12, bg = "white"))

setwd(path)
dir.create("canada_test")
setwd("canada_test")

minicanada(canada_abb, 1:13)
dev.off()

test_that("Canada is drawn correctly 1", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[1]))
})

minicanada(canada_abb, 1:13, border_colors = rep("red", 13), 
        pt_names = FALSE)
dev.off()

test_that("Canada is drawn correctly 2", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[2]))
})

minicanada(canada_abb, rep("black", 13), border_colors = rep("white", 13), 
        pt_name_colors = rep("yellow", 13), pt_name_cex = .5, 
        font = "serif")
dev.off()

test_that("Canada is drawn correctly 3", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[3]))
})

setwd(path)

test_that("minicanada() throws appropriate errors", {
  expect_error(minicanada(canada_abb[1:10], 1:13))
  expect_error(minicanada(canada_abb, 1:10))
  expect_error(minicanada(canada_abb, 1:13, border_colors = 1:10))
  expect_error(minicanada(canada_abb, 1:13, pt_names = NA))
  expect_error(minicanada(canada_abb, 1:13, pt_name_colors = 1:10))
})

unlink("canada_test", recursive = TRUE, force = TRUE)
setwd(oldwd)
options(device = old_device)
