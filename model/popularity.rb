class Popularity
  def initialize(popularity)
    @popularity = popularity
  end

  def response
    raise NotImplementedError, 'Subclasses must implement a response method'
  end
end

class VeryPopular < Popularity
  def response
    'muy popular'
  end
end

class Popular < Popularity
  def response
    'popular'
  end
end

class PopularityFactory
  VERY_POPULAR = 90

  def self.popularity_for(popularity)
    return VeryPopular.new(popularity) if popularity >= VERY_POPULAR

    Popular.new(popularity)
  end
end
