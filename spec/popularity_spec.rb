require 'spec_helper'
require "#{File.dirname(__FILE__)}/../model/popularity"

describe Popularity do
  it 'should respond with "muy popular" for a VeryPopular artist' do
    popularity = described_class.new
    expect(popularity.response).to eq('muy popular')
  end
end
