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
  expect_equal(digest(file = usa1), "cbfd13ce4a27c50fb44a51ee49334ea1")
  expect_equal(digest(file = usa2), "4a05d1ce33df5c6006762d46f867c677")
  expect_equal(digest(file = usa3), "a259542b43efabbc2ce261a30065e68e")
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
