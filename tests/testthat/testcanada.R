library(png)
context("Test minicanada()")


path <- tempdir()
oldwd <- getwd()

setwd(path)
dir.create("canada_test")

canada1 <- file.path("canada_test", "canada1.png")
png(canada1)
minicanada(canada_abb, 1:13)
dev.off()

canada2 <- file.path("canada_test", "canada2.png")
png(canada2)
minicanada(canada_abb, 1:13, border_colors = rep("red", 13), 
        pt_names = FALSE)
dev.off()

canada3 <- file.path("canada_test", "canada3.png")
png(canada3)
minicanada(canada_abb, rep("black", 13), border_colors = rep("white", 13), 
        pt_name_colors = rep("yellow", 13), pt_name_cex = .5, 
        font = "serif")
dev.off()

masters <- system.file(file.path("images", paste0("canada", 1:3, ".png")), package = "minimap")

test_that("Canada is drawn correctly", {
  expect_equal(readPNG(canada1), readPNG(masters[1]))
  expect_equal(readPNG(canada2), readPNG(masters[2]))
  expect_equal(readPNG(canada3), readPNG(masters[3]))
})

test_that("minicanada() throws appropriate errors", {
  expect_error(minicanada(canada_abb[1:10], 1:13))
  expect_error(minicanada(canada_abb, 1:10))
  expect_error(minicanada(canada_abb, 1:13, border_colors = 1:10))
  expect_error(minicanada(canada_abb, 1:13, pt_names = NA))
  expect_error(minicanada(canada_abb, 1:13, pt_name_colors = 1:10))
})

unlink("canada_test", recursive = TRUE, force = TRUE)
setwd(oldwd)
