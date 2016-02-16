library(digest)
context("Test miniusa()")


path <- tempdir()
oldwd <- getwd()

setwd(path)
dir.create("usa_test")

usa1 <- file.path("usa_test", "usa1.png")
png(usa1)
miniusa(usa_abb, 1:51)
dev.off()

usa2 <- file.path("usa_test", "usa2.png")
png(usa2)
miniusa(usa_abb, 1:51, border_colors = rep("red", 51), 
           state_names = FALSE)
dev.off()

usa3 <- file.path("usa_test", "usa3.png")
png(usa3)
miniusa(usa_abb, rep("black", 51), border_colors = rep("white", 51), 
           state_name_colors = rep("yellow", 51), state_name_cex = .5, 
           font = "serif")
dev.off()

test_that("The USA is drawn correctly", {
  expect_equal(digest(file = usa1, algo = "sha1"), "e6dc0e728f4de5d611f46e6c56ac6aa9b2fed3c0")
  expect_equal(digest(file = usa2, algo = "sha1"), "b7a552319d3f4bd5d3d9d0e1e5856f4dfed4d322")
  expect_equal(digest(file = usa3, algo = "sha1"), "2e7ca543ecfc7f46d46777a957b52d629edd3de4")
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
