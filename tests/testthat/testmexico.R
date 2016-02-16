library(png)
context("Test minimexico()")


path <- tempdir()
oldwd <- getwd()
old_device <- options()$device
masters <- system.file(file.path("images", paste0("mex", 1:3, ".png")), 
                       package = "minimap")
options(device = function() png(width = 480, height = 480, units = "px", 
                                pointsize = 12, bg = "white"))

setwd(path)
dir.create("mexico_test")
setwd("mexico_test")

minimexico(mexico_abb, 1:32)
dev.off()

test_that("Mexico is drawn correctly 1", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[1]))
})

minimexico(mexico_abb, 1:32, border_colors = rep("red", 32), 
           estados_names = FALSE)
dev.off()

test_that("Mexico is drawn correctly 2", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[2]))
})

minimexico(mexico_abb, rep("black", 32), border_colors = rep("white", 32), 
           estados_name_colors = rep("yellow", 32), estados_name_cex = .5, 
           font = "serif")
dev.off()

test_that("Mexico is drawn correctly 3", {
  expect_equal(readPNG("Rplot001.png"), readPNG(masters[3]))
})

setwd(path)

test_that("minimexico() throws appropriate errors", {
  expect_error(minimexico(mexico_abb[1:10], 1:32))
  expect_error(minimexico(mexico_abb, 1:10))
  expect_error(minimexico(mexico_abb, 1:32, border_colors = 1:10))
  expect_error(minimexico(mexico_abb, 1:32, estados_names = NA))
  expect_error(minimexico(mexico_abb, 1:32, estados_name_colors = 1:10))
})

unlink("mexico_test", recursive = TRUE, force = TRUE)
setwd(oldwd)
options(device = old_device)
