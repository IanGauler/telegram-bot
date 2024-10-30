class DobleConectorSpotify
  def initialize(popularity)
    @popularity = popularity
  end

  def obtener_popularidad_de(_artist_name)
    @popularity
  end
end
