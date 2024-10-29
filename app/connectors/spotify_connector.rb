class SpotifyConnector
  def get_popularity_for(artist_name)
    api_key = ENV['SPOTIFY_API_KEY']
    url = 'https://api.spotify.com/v1/search'
    begin
      api_response = Faraday.get(url,
                                 { q: artist_name, type: 'artist', limit: 1, market: 'AR' },
                                 { Authorization: "Bearer #{api_key}" })
      if api_response.success?
        response_json = JSON.parse(api_response.body)
        response_json.dig('artists', 'items', 0, 'popularity')
      else
        raise 'No se pudo obtener la popularidad del artista en este momento. Intenta más tarde.'
      end
    rescue StandardError => e
      raise "Error en la llamada a Spotify: #{e.message}"
    end
  end
end
