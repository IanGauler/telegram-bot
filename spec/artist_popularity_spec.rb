require 'spec_helper'
require "#{File.dirname(__FILE__)}/../model/artist_popularity"
require "#{File.dirname(__FILE__)}/spec_helpers/spotify_connector_double"

describe ArtistPopularity do
  it 'spotify popularity is created with artist name' do
    connector_double = SpotifyConnectorDouble.new(92)
    artist_popularity = described_class.create_with_connector(connector_double)
    expect(artist_popularity).not_to be_nil
  end

  it 'should respond with "muy popular" for a very popular artist' do
    artist_name = 'Lady Gaga'
    connector_double = SpotifyConnectorDouble.new(92)
    artist_popularity = described_class.create_with_connector(connector_double)
    popularity = artist_popularity.popularity(artist_name)
    expect(popularity).to eq('muy popular')
  end

  it 'should respond with "popular" for a popular artist' do
    artist_name = 'Kygo'
    connector_double = SpotifyConnectorDouble.new(88)
    artist_popularity = described_class.create_with_connector(connector_double)
    popularity = artist_popularity.popularity(artist_name)
    expect(popularity).to eq('popular')
  end
end
