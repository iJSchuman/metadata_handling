
# ---- List files ----
files <- list.files("./Data/Raw", full.names = TRUE)

# ---- Extract column names ----
results <- lapply(files, function(f) {
  
  ext <- tools::file_ext(f)
  
  cols <- tryCatch({
    if (ext == "csv") {
      names(readr::read_csv(f, n_max = 0, show_col_types = FALSE))
    } else if (ext == "xlsx") {
      names(readxl::read_excel(f, n_max = 0))
    }
  }, error = function(e) {
    warning(paste("Failed to read:", f))
    return(NA)
  })
  
  data.frame(
    file = basename(f),
    column = cols,
    stringsAsFactors = FALSE
  )
})


# Combine into one dataframe
out <- do.call(rbind, results)
View(out)
