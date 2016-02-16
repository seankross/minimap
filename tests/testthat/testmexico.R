library(digest)
context("Test minimexico()")


path <- tempdir()
oldwd <- getwd()

setwd(path)
dir.create("mexico_test")

mex1 <- file.path("mexico_test", "mex1.png")
png(mex1)
minimexico(mexico_abb, 1:32)
dev.off()

mex2 <- file.path("mexico_test", "mex2.png")
png(mex2)
minimexico(mexico_abb, 1:32, border_colors = rep("red", 32), 
           estados_names = FALSE)
dev.off()

mex3 <- file.path("mexico_test", "mex3.png")
png(mex3)
minimexico(mexico_abb, rep("black", 32), border_colors = rep("white", 32), 
           estados_name_colors = rep("yellow", 32), estados_name_cex = .5, 
           font = "serif")
dev.off()

test_that("Mexico is drawn correctly", {
  expect_equal(digest(file = mex1, algo = "sha1"), "aa027bd8a257af1e6cd0cdfc38ac08d45a5d221c")
  expect_equal(digest(file = mex2, algo = "sha1"), "d4be901dc77d5ecad1215804f74bc02e65227508")
  expect_equal(digest(file = mex3, algo = "sha1"), "100c65d70f20a2aff0da5c730c6c20d3b2dbf0c2")
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
