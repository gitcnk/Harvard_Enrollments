# List of PDF URLs 
pdf_urls <- c(
  "https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/6/210/files/2024/08/Factbook_2017_2018.pdf",
  "https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/6/210/files/2024/08/Factbook_2018_2019.pdf",
  "https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/6/210/files/2024/08/Factbook_2019_2020.pdf",
  "https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/6/210/files/2024/08/Factbook_2020_2021.pdf",
  "https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/6/210/files/2024/08/Factbook_2021_2022.pdf",
  'https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/6/210/files/2024/08/Factbook_2022_2023.pdf',
  'https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/6/210/files/2025/05/Factbook_2023_2024.pdf'
)

n_years <- 7
# Corresponding filenames
pdf_files <- paste0("harvard_fact_book_", 1:n_years, ".pdf")  # Adjust years accordingly

# Download PDFs
for (i in seq_along(pdf_urls)) {
  download.file(pdf_urls[i], 
                destfile = pdf_files[i], mode = "wb")
}


temp <- list()

### Extract tables
for(i in 1:n_years)
{
  filename <- paste('harvard_fact_book_',i,'.pdf', sep = '')
  text_pages <- pdf_text(filename)
  
  # View specific pages
  cat(text_pages[11])  # Try different pages until you find the table
  
  
  
  # Extract the page with the table
  lines <- str_split(text_pages[11], "\n")[[1]]
  
  header_line <- lines[3]
  data_line   <- lines[7]
  
  
  races    <- str_split(header_line, "\\s{2,}")[[1]]   # 2 or more spaces = new column
  counts <- str_split(data_line, "\\s{2,}")[[1]]
  
  races <- races[2:7]
  counts <- counts[3:8]
  counts_clean <- as.numeric(gsub(",", "", counts))
  
  # Create data frame
  temp[[i]] <- data.frame(Race = races,
                          Count = as.numeric(counts_clean),
                          Year = i,
                          stringsAsFactors = TRUE)
  
}



## Create a dataframe

race_labels <- c('Native_American', 'Asian', 'Black', 'Hispanic','Hawaiian or Pacific Islander' ,'White')
years <- c('2017-2018', '2018-2019','2019-2020','2020-2021','2021-2022' ,'2022-2023', '2023-2024')
n_races <- length(race_labels)

Academic_Year <- NULL

for(j in 1:n_years)
{
  Academic_Year <- append(Academic_Year,
                          
                          rep(years[j],n_races)
                          
  ) 
}

Academic_Year 

race_df <- data.frame( Academic_Year = c(rep(years[1], 6),
                                         rep(years[2], 6),
                                         rep(years[3], 6),
                                         rep(years[4], 6),
                                         rep(years[5], 6)),
                       Race = rep(race_labels, 5),
                       Count = c(temp[[1]]$Count,
                                 temp[[2]]$Count,
                                 temp[[3]]$Count,
                                 temp[[4]]$Count,
                                 temp[[5]]$Count)
                       
)

