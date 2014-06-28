require 'open-uri'

class SaleCreator
  def initialize(store_name)
    @store_name = store_name
  end

  def create
    if @store_name == "coop"
      coop_sale
    elsif @store_name == "superstore"
      superstore_sale
    end
    create_sale
  end

  private

  def coop_sale
    url = "http://coopwinespiritsbeer.com/wines/weekly_specials/"
    doc = Nokogiri::HTML(open(url))
    @root = doc.at_css("#primary-content li:nth-child(2) a")
    Cloudinary::Uploader.upload(@root.first.last, :public_id => @root.text, url: @root.first.last)
    @name = "Co-op Liquor"
  end

  def superstore_sale
    url = "http://realcanadianliquorstore.ca/"
    doc = Nokogiri::HTML(open(url))
    root = doc.at_css("#right-flyer-container img")

    @root_url = root.xpath('//div/a/@href').first.value
    @root_text = "Superstore Liquor - " + Date.today.to_s
    @picture = root.xpath('//div/a/img/@src').first.value
    @name = "Superstore Liquor"
  end

  def create_sale
    @sale = Sale.new(url: @root_url, picture: @picture, store_name: @name)
    @sale.save
  end
end
