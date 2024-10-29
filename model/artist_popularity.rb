require_relative 'popularity'

class ArtistPopularity
  VERY_POPULAR = 90

  def self.create_with_connector(connector)
    ArtistPopularity.new(connector)
  end

  def initialize(connector)
    @connector = connector
  end

  def popularity(artist_name)
    popularity = @connector.get_popularity_for(artist_name)
    PopularityFactory.popularity_for(popularity).response
  end
end
