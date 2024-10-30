require 'spec_helper'
require 'dotenv/load'
require "#{File.dirname(__FILE__)}/../../app/conector_spotify"

describe ConectorSpotify do
  it 'returns a popularity score between 0 and 100 for a given artist' do
    WebMock.allow_net_connect!

    nombre_artista = 'Nirvana'
    conector_spotify = described_class.new
    popularidad = conector_spotify.obtener_popularidad_de(nombre_artista)
    expect(popularidad).to be_between(0, 100)

    WebMock.disable_net_connect!(allow_localhost: true)
  end
end
