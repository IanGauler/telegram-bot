class SpotifyConnectorDouble
  def initialize(popularity)
    @popularity = popularity
  end

  def get_popularity_for(_artist_name)
    @popularity
  end
end
