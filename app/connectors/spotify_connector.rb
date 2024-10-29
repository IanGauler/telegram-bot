class SpotifyConnector
  def get_popularity_for(artist_name)
    api_key = ENV['SPOTIFY_API_KEY']
    url = 'https://api.spotify.com/v1/search'
    api_response = Faraday.get(url,
                               { q: artist_name, type: 'artist', limit: 1, market: 'AR' },
                               { Authorization: "Bearer #{api_key}" })
    response_json = JSON.parse(api_response.body)
    response_json['artists']['items'][0]['popularity']
  end
end
