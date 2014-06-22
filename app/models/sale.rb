require 'open-uri'

class Sale < ActiveRecord::Base
  validates_uniqueness_of :url
  validates_uniqueness_of :picture

  scope :current_week, ->{ where("created_at > ?", 1.week.ago).order(created_at: :desc) }

  # def generate_sales
  #   create_coop_sale
  # end

  # private

  # def create_coop_sale
  #   url = "http://coopwinespiritsbeer.com/wines/weekly_specials/"
  #   doc = Nokogiri::HTML(open(url))
  #   root = doc.at_css("#primary-content li:nth-child(3) a")

  #   Cloudinary::Uploader.upload(root.first.last, :public_id => root.text, url: root.text)
  #   sale = Sale.new(url: root.first.last, picture: root.text)
  #   sale.save
  #   # Cloudinary::Uploader.upload("SinglePageSample.pdf", :public_id => "single_page_pdf")
  # end
end
