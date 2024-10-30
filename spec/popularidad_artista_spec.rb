require 'spec_helper'
require "#{File.dirname(__FILE__)}/../model/popularidad_artista"
require "#{File.dirname(__FILE__)}/spec_helpers/doble_conector_spotify"

describe PopularidadArtista do
  it 'PopularidadArtista is created with a connector' do
    popularidad = 92
    doble_conector = DobleConectorSpotify.new(popularidad)
    popularidad_artista = described_class.crear_con_conector(doble_conector)
    expect(popularidad_artista).not_to be_nil
  end

  it 'should respond with "muy popular" for a very popular artist' do
    nombre_artista = 'Lady Gaga'
    popularidad = 92
    doble_conector = DobleConectorSpotify.new(popularidad)
    popularidad_artista = described_class.crear_con_conector(doble_conector)
    popularidad = popularidad_artista.popularidad_de(nombre_artista)
    expect(popularidad).to eq('muy popular')
  end

  it 'should respond with "popular" for a popular artist' do
    nombre_artista = 'Kygo'
    popularidad = 88
    doble_conector = DobleConectorSpotify.new(popularidad)
    popularidad_artista = described_class.crear_con_conector(doble_conector)
    popularidad = popularidad_artista.popularidad_de(nombre_artista)
    expect(popularidad).to eq('popular')
  end
end
