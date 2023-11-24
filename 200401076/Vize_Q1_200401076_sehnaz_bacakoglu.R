library(httr)

spotify_token <- function() {
  readRenviron("./.Renviron")
  client_id <- Sys.getenv("SPOTIFY_CLIENT_ID")
  client_secret <- Sys.getenv("SPOTIFY_CLIENT_SECRET")
  
  
  # Token almak için gerekli URL
  token_url <- "https://accounts.spotify.com/api/token"
  
  # Token almak için kullanılacak POST isteği için gerekli bilgiler
  body <- list(
    grant_type = "client_credentials"
  )
  
  # httr paketi ile POST isteği yapma
  response <- httr::POST(
    url = token_url,
    body = body,
    authenticate(client_id, client_secret),
    encode = "form"
  )
  
  # HTTP status kodunu alma
  status_code <- httr::status_code(response)
  
  # Token stringini alma
  token <- paste("Bearer", httr::content(response)$access_token, sep = " ")
  
  # Sonuçları liste olarak döndürme
  result <- list(
    status_code = status_code,
    token = token
  )
  
  return(result)
}

# Fonksiyonu çağırma
result <- spotify_token()
print(result)