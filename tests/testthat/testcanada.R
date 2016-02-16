library(digest)
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

test_that("The Canada is drawn correctly", {
  expect_equal(digest(file = canada1), "acc614a387cf7c1ad63229029ad8d323")
  expect_equal(digest(file = canada2), "2387939675941d64e9d919280f558ca8")
  expect_equal(digest(file = canada3), "23e5118f32f684db776ca3840d345dd4")
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
