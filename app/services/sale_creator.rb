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
    elsif @store_name == "liquor depot"
      liquor_depot_sale
    end
    create_sale
  end

  private

  def liquor_depot_sale
    url = "http://www.liquorstoresgp.ca/Specials/Alberta/Flyer"
    doc = Nokogiri::HTML(open(url))
    root = doc.at_css("#dnn_ctr1360_ModuleContent img")

    @name = "Liquor Depot"
    @root_url = root.xpath('//div/a/@href')[6].value
    @picture = "http://www.liquorstoresgp.ca" + root.attributes["src"].value
  end

  def coop_sale
    url = "http://coopwinespiritsbeer.com/wines/weekly_specials/"
    doc = Nokogiri::HTML(open(url))
    @root = doc.at_css("#primary-content li:nth-child(1) a")
    upload = Cloudinary::Uploader.upload(@root.first.last)
    @name = "Co-op Liquor"
    @root_url = upload["url"]
    picture = ApplicationController.helpers.cl_image_tag("#{upload["public_id"]}.png")
    @picture = picture[37..115]
  end

  def superstore_sale
    url = "http://realcanadianliquorstore.ca/"
    doc = Nokogiri::HTML(open(url))
    root = doc.at_css("#right-flyer-container img")

    @root_url = root.xpath('//div/a/@href').first.value
    @picture = root.xpath('//div/a/img/@src').first.value
    @name = "Superstore Liquor"
  end

  def create_sale
    @sale = Sale.new(url: @root_url, picture: @picture, store_name: @name)
    @sale.save
  end
end
