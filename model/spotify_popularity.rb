class SpotifyPopularity
  VERY_POPULAR = 90

  def self.create_with_connector(connector)
    SpotifyPopularity.new(connector)
  end

  def initialize(connector)
    @connector = connector
  end

  def popularity(artist_name)
    popularity = @connector.get_popularity_for(artist_name)
    return 'muy popular' if popularity >= VERY_POPULAR

    'popular'
  end
end
