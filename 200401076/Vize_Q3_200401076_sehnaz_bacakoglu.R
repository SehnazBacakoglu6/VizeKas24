# Spotify search fonksiyonu
spotify_search_artist <- function(artist_name) {
  # Fonksiyon kodları (Yukarıdaki örnekte verilmiştir)
}

# Sevilen ve sevilmeyen sanatçı isimleri
favorite_artists <- c("SevilenArtist1", "SevilenArtist2", "SevilenArtist3", "SevilenArtist4", "SevilenArtist5")
disliked_artist <- "SevilmeyenArtist"

# Sanatçı ID'lerini toplamak için boş bir data frame oluştur
my_artists <- data.frame(artist = character(0), id = character(0), stringsAsFactors = FALSE)

# Sevilen sanatçı ID'lerini çek
for (artist in favorite_artists) {
  search_result <- spotify_search_artist(artist)
  
  # İlk sonuçu al
  if (length(search_result$search_results$artist) > 0) {
    first_result <- search_result$search_results[1, ]
    
    # Data frame'e ekle
    my_artists <- rbind(my_artists, data.frame(artist = first_result$artist, id = first_result$id, stringsAsFactors = FALSE))
  }
}

# Sevilmeyen sanatçı ID'sini çek
search_result_disliked <- spotify_search_artist(disliked_artist)
if (length(search_result_disliked$search_results$artist) > 0) {
  first_result_disliked <- search_result_disliked$search_results[1, ]
  
  # Data frame'e ekle
  my_artists <- rbind(my_artists, data.frame(artist = first_result_disliked$artist, id = first_result_disliked$id, stringsAsFactors = FALSE))
}

# Sonuçları yazdır
print(my_artists)

