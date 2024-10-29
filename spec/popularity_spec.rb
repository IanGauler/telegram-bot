require 'spec_helper'
require "#{File.dirname(__FILE__)}/../model/popularity"

describe Popularity do
  it 'should respond with "muy popular" for a VeryPopular artist' do
    very_popular_number = 92
    popularity = PopularityFactory.create(very_popular_number)
    expect(popularity.response).to eq('muy popular')
  end

  it 'should respond with "popular" for a Popular artist' do
    popular_number = 88
    popularity = PopularityFactory.create(popular_number)
    expect(popularity.response).to eq('popular')
  end
end
