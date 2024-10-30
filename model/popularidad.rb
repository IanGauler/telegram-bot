class Popularidad
  def respuesta
    raise NotImplementedError, 'Las subclases deben implementar este metodo'
  end
end

class MuyPopular < Popularidad
  def respuesta
    'muy popular'
  end
end

class Popular < Popularidad
  def respuesta
    'popular'
  end
end

class Desconocido < Popularidad
  def respuesta
    'desconocido'
  end
end

class FabricaPopularidad
  UMBRAL_MUY_POPULAR = 90
  UMBRAL_POPULAR = 70

  def popularidad_para_puntaje(popularidad)
    return MuyPopular.new if popularidad >= UMBRAL_MUY_POPULAR
    return Popular.new if popularidad >= UMBRAL_POPULAR

    Desconocido.new
  end
end
