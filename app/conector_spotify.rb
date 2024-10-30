class ConectorSpotify
  SPOTIFY_API_URL = 'https://api.spotify.com/v1/search'.freeze

  def obtener_popularidad_de(nombre_artista)
    respuesta_api = buscar_data_artista(nombre_artista)
    manejar_respuesta_api(respuesta_api)
  rescue StandardError => e
    raise "Error en la comunicación con Spotify: #{e.message}"
  end

  private

  def buscar_data_artista(nombre_artista)
    api_key = ENV['SPOTIFY_API_KEY']
    Faraday.get(SPOTIFY_API_URL,
                { q: nombre_artista, type: 'artist', limit: 1, market: 'AR' },
                { Authorization: "Bearer #{api_key}" })
  end

  def manejar_respuesta_api(respuesta_api)
    if respuesta_api.success?
      popularidad = extraer_popularidad(respuesta_api)
      return popularidad if popularidad

      raise 'Formato de respuesta inesperado. Comunícate con el administrador.'
    else
      manejar_error_api(respuesta_api)
    end
  end

  def extraer_popularidad(respuesta_api)
    response_json = JSON.parse(respuesta_api.body)
    response_json.dig('artists', 'items', 0, 'popularity')
  end

  def manejar_error_api(respuesta_api)
    case respuesta_api.status
    when 401
      raise 'No se pudo autenticar con Spotify. Comunícate con el administrador.'
    else
      raise 'No se pudo obtener la popularidad del artista en este momento. Intenta más tarde.'
    end
  end
end
