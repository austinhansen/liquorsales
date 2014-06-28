require 'rails_helper'
require 'open-uri'
require 'nokogiri'

describe "SaleCreator" do
  it "creates a new superstore sale" do
    params = "superstore"
    sale_creator = SaleCreator.new(params)
    expect { sale_creator.create }.to change{Sale.count}.by(1)
  end
end
