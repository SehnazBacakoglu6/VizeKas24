library(httr)

spotify_search_artist <- function(artist_name) {
  # Spotify API'ye erişim için gerekli bilgiler
  client_id <- "2bd8651c42af46a1860f89d1d86ddf95"
  client_secret <- "aa42adaf183a4e6d875f91b3fa79e687"
  
  # Token almak için kullanılan fonksiyon
  get_spotify_token <- function() {
    token_url <- "https://accounts.spotify.com/api/token"
    body <- list(grant_type = "client_credentials")
    response <- httr::POST(url = token_url, body = body, authenticate(client_id, client_secret), encode = "form")
    return(httr::content(response)$access_token)
  }
  
  # Spotify API'ye artist arama isteği yapma fonksiyonu
  search_artist <- function(token, artist_name) {
    search_url <- paste0("https://api.spotify.com/v1/search?q=", URLencode(artist_name), "&type=artist&limit=1")
    response <- httr::GET(url = search_url, add_headers(Authorization = paste("Bearer", token)))
    return(httr::content(response))
  }
  
  # Token al
  token <- get_spotify_token()
  
  # Artist ara ve sonuçları al
  search_results <- search_artist(token, artist_name)
  
  # HTTP status kodunu al
  status_code <- httr::status_code(search_results)
  
  # Data.frame oluştur
  artist_df <- data.frame(
    artist = search_results$artists$items$name,
    id = search_results$artists$items$id
  )
  
  # Sonuçları liste olarak döndür
  result <- list(
    status_code = status_code,
    search_results = artist_df
  )
  
  return(result)
}

# Fonksiyonu kullanma örneği
search_result <- spotify_search_artist("Ed Sheeran")
print(search_result)

