require 'spec_helper'
require "#{File.dirname(__FILE__)}/../model/popularidad"

describe Popularidad do
  it 'should respond with "muy popular" for a VeryPopular artist' do
    calificacion_muy_popular = 92
    metrica_popularidad = FabricaPopularidad.new.popularidad_para_puntaje(calificacion_muy_popular)
    expect(metrica_popularidad.respuesta).to eq('muy popular')
  end

  it 'should respond with "popular" for a Popular artist' do
    calificacion_popular = 88
    metrica_popularidad = FabricaPopularidad.new.popularidad_para_puntaje(calificacion_popular)
    expect(metrica_popularidad.respuesta).to eq('popular')
  end

  it 'should respond with "desconocido" for an Unknown artist' do
    calificacion_desconocido = 50
    metrica_popularidad = FabricaPopularidad.new.popularidad_para_puntaje(calificacion_desconocido)
    expect(metrica_popularidad.respuesta).to eq('desconocido')
  end
end
