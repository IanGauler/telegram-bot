require 'spec_helper'
require "#{File.dirname(__FILE__)}/../model/spotify_popularity"
require "#{File.dirname(__FILE__)}/spec_helpers/spotify_connector_double"

describe SpotifyPopularity do
  it 'spotify popularity is created with artist name' do
    connector_double = SpotifyConnectorDouble.new(92)
    spotify_popularity = described_class.create_with_connector(connector_double)
    expect(spotify_popularity).not_to be_nil
  end

  it 'should respond with "muy popular" for a very popular artist' do
    artist_name = 'Lady Gaga'
    connector_double = SpotifyConnectorDouble.new(92)
    spotify_popularity = described_class.create_with_connector(connector_double)
    popularity = spotify_popularity.popularity(artist_name)
    expect(popularity).to eq('muy popular')
  end

  it 'should respond with "popular" for a popular artist' do
    artist_name = 'Kygo'
    connector_double = SpotifyConnectorDouble.new(88)
    spotify_popularity = described_class.create_with_connector(connector_double)
    popularity = spotify_popularity.popularity(artist_name)
    expect(popularity).to eq('popular')
  end
end
