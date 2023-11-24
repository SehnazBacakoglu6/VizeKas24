library(testthat)

test_that("Workspace'teki tüm değişkenleri silme", {
  rm(list = ls())
  expect_equal(length(ls()), 0)
})

source("Vize_Q2_200401076_sehnaz_bacakoglu.R")



# Test 2.1
if (!exists("spotify_search_artist")) {
  stop("Test 2.1 failed: spotify_search_artist variable does not exist in the global workspace.")
}

# Test 2.2
if (typeof(spotify_search_artist) != "closure") {
  stop("Test 2.2 failed: spotify_search_artist is not a function.")
}

# Test 2.3
result <- spotify_search_artist("TestArtist")
if (!is.list(result)) {
  stop("Test 2.3 failed: The output of spotify_search_artist() is not a list.")
}

# Test 2.4
if (length(result) != 2) {
  stop("Test 2.4 failed: The output of spotify_search_artist() does not have two elements.")
}

# Test 2.5
if (!"status_code" %in% names(result)) {
  stop("Test 2.5 failed: The first element of the output does not have the name 'status_code'.")
}

# Test 2.6
if (class(result$status_code) != "numeric") {
  stop("Test 2.6 failed: The class of 'status_code' is not numeric.")
}

# Test 2.7
if (result$status_code != 200) {
  stop("Test 2.7 failed: The value of 'status_code' is not equal to 200.")
}

# Test 2.8
if (!"search_results" %in% names(result)) {
  stop("Test 2.8 failed: The second element of the output does not have the name 'search_results'.")
}

# Test 2.9
if (class(result$search_results) != "data.frame") {
  stop("Test 2.9 failed: The class of 'search_results' is not data.frame.")
}

# Test 2.10
if (ncol(result$search_results) != 2) {
  stop("Test 2.10 failed: The 'search_results' data.frame does not have two columns.")
}

# Test 2.11
if (!identical(names(result$search_results), c("artist", "id"))) {
  stop("Test 2.11 failed: The column names of 'search_results' are not c('artist', 'id').")
}

# Test 2.12
if (result$search_results$id[1] != "22WZ7M8sxp5THdruNY3gXt") {
  stop("Test 2.12 failed: The ID of the first row in 'search_results' is not '22WZ7M8sxp5THdruNY3gXt'.")
}

# If all tests pass, print a success message
cat("All tests passed successfully!\n")