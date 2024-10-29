class Popularity
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

class Unknown < Popularity
  def response
    'desconocido'
  end
end

class PopularityFactory
  VERY_POPULAR = 90
  POPULAR = 70

  def self.popularity_for(popularity)
    return VeryPopular.new if popularity >= VERY_POPULAR
    return Popular.new if popularity >= POPULAR

    Unknown.new
  end
end
