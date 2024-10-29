require 'spec_helper'
require "#{File.dirname(__FILE__)}/../model/spotify_popularity"

describe SpotifyPopularity do
  it 'spotify popularity is created with artist name' do
    spotify_popularity = described_class.new
    expect(spotify_popularity).not_to be_nil
  end

  it 'should respond with "muy popular" for a very popular artist' do
    artist_name = 'Lady Gaga'
    spotify_popularity = described_class.new
    popularity = spotify_popularity.popularity(artist_name)
    expect(popularity).to eq('muy popular')
  end
end
