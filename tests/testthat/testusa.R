library(png)
context("Test miniusa()")


path <- tempdir()
oldwd <- getwd()

setwd(path)
dir.create("usa_test")

usa1 <- file.path("usa_test", "usa1.png")
png(usa1, width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
miniusa(usa_abb, 1:51)
dev.off()

usa2 <- file.path("usa_test", "usa2.png")
png(usa2, width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
miniusa(usa_abb, 1:51, border_colors = rep("red", 51), 
           state_names = FALSE)
dev.off()

usa3 <- file.path("usa_test", "usa3.png")
png(usa3, width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
miniusa(usa_abb, rep("black", 51), border_colors = rep("white", 51), 
           state_name_colors = rep("yellow", 51), state_name_cex = .5, 
           font = "serif")
dev.off()

masters <- system.file(file.path("images", paste0("usa", 1:3, ".png")), package = "minimap")

test_that("The USA is drawn correctly", {
  expect_equal(readPNG(usa1), readPNG(masters[1]))
  expect_equal(readPNG(usa2), readPNG(masters[2]))
  expect_equal(readPNG(usa3), readPNG(masters[3]))
})

test_that("miniusa() throws appropriate errors", {
  expect_error(miniusa(usa_abb[1:10], 1:51))
  expect_error(miniusa(usa_abb, 1:10))
  expect_error(miniusa(usa_abb, 1:51, border_colors = 1:10))
  expect_error(miniusa(usa_abb, 1:51, state_names = NA))
  expect_error(miniusa(usa_abb, 1:51, state_name_colors = 1:10))
})

unlink("usa_test", recursive = TRUE, force = TRUE)
setwd(oldwd)
