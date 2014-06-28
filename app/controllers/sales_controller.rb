class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    @sales = Sale.current_week
  end

  def show
  end

  def new
    @sale = Sale.new
  end

  def edit
  end

  def create
    superstore

    @sale = Sale.new(url: @root_url, picture: @picture, store_name: @name)
    @sale.save

    respond_to do |format|
      if @sale.save
        format.html { redirect_to sales_path, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def coop
      url = "http://coopwinespiritsbeer.com/wines/weekly_specials/"
      doc = Nokogiri::HTML(open(url))
      @root = doc.at_css("#primary-content li:nth-child(2) a")
      Cloudinary::Uploader.upload(@root.first.last, :public_id => @root.text, url: @root.first.last)
      @name = "Co-op Liquor"
    end

    def superstore
      url = "http://realcanadianliquorstore.ca/"
      doc = Nokogiri::HTML(open(url))
      @root = doc.at_css("#right-flyer-container img")
      @root_url = @root.xpath('//div/a/@href').first.value
      @root_text = "Superstore Liquor - " + Date.today.to_s
      @picture = @root.xpath('//div/a/img/@src').first.value
      @name = "Superstore Liquor"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:url, :picture)
    end
end
