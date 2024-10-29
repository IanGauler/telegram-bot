require 'spec_helper'
require 'dotenv/load'
require "#{File.dirname(__FILE__)}/../../app/connectors/spotify_connector"

describe SpotifyConnector do
  it 'returns a popularity score between 0 and 100 for a given artist' do
    WebMock.allow_net_connect!

    artist_name = 'Nirvana'
    spotify_connector = described_class.new
    popularity = spotify_connector.get_popularity_for(artist_name)
    expect(popularity).to be_between(0, 100)

    WebMock.disable_net_connect!(allow_localhost: true)
  end
end
