library(png)
context("Test minimexico()")


path <- tempdir()
oldwd <- getwd()

setwd(path)
dir.create("mexico_test")

mex1 <- file.path("mexico_test", "mex1.png")
png(mex1, width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
minimexico(mexico_abb, 1:32)
dev.off()

mex2 <- file.path("mexico_test", "mex2.png")
png(mex2, width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
minimexico(mexico_abb, 1:32, border_colors = rep("red", 32), 
           estados_names = FALSE)
dev.off()

mex3 <- file.path("mexico_test", "mex3.png")
png(mex3, width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
minimexico(mexico_abb, rep("black", 32), border_colors = rep("white", 32), 
           estados_name_colors = rep("yellow", 32), estados_name_cex = .5, 
           font = "serif")
dev.off()

masters <- system.file(file.path("images", paste0("mex", 1:3, ".png")), package = "minimap")

test_that("Mexico is drawn correctly", {
  expect_equal(readPNG(mex1), readPNG(masters[1]))
  expect_equal(readPNG(mex2), readPNG(masters[2]))
  expect_equal(readPNG(mex3), readPNG(masters[3]))
})

test_that("minimexico() throws appropriate errors", {
  expect_error(minimexico(mexico_abb[1:10], 1:32))
  expect_error(minimexico(mexico_abb, 1:10))
  expect_error(minimexico(mexico_abb, 1:32, border_colors = 1:10))
  expect_error(minimexico(mexico_abb, 1:32, estados_names = NA))
  expect_error(minimexico(mexico_abb, 1:32, estados_name_colors = 1:10))
})

unlink("mexico_test", recursive = TRUE, force = TRUE)
setwd(oldwd)
