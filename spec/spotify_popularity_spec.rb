require 'spec_helper'
require "#{File.dirname(__FILE__)}/../model/spotify_popularity"

describe SpotifyPopularity do
  it 'spotify popularity is created with artist name' do
    artist_name = 'Lady Gaga'
    spotify_popularity = described_class.new(artist_name)
    expect(spotify_popularity.artist_name).to eq(artist_name)
  end
end
