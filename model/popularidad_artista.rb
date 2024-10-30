require_relative 'popularidad'

class PopularidadArtista
  def self.crear_con_conector(conector)
    PopularidadArtista.new(conector)
  end

  def initialize(conector)
    @conector = conector
  end

  def popularidad_de(nombre_artista)
    popularidad = @conector.obtener_popularidad_de(nombre_artista)
    FabricaPopularidad.new.popularidad_para_puntaje(popularidad).respuesta
  end
end
