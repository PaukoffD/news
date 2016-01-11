class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  require 'open-uri'
  
  # GET /pages
  # GET /pages.json
  def load
   page1 = Nokogiri::HTML(open("http://www.vesti.ru/news/"))
 
   page1.css(".b-item__inner").each do |link|
    @p=Page.new
    #@notice.notice=link.at_css(".ob_title").text
	#s=link.at_css(".photo_preview")
	#if !s.name="td"
	# @notice.ref_img=link.at_css(".photo_preview img")['src']
	#end 
	#@notice.ref_page=link.at_css(".ob_descr td a")['href']
	#@notice.name=link.at_css(".author").text
	
	#@notice.text=link.at_css("p[3]").text
	@p.title=link.at_css(".b-item__title").text
	@p.ref="www.vesti.ru"+link.at_css(".b-item__title a")['href']
	@p.time=link.at_css(".b-item__time").text
	
	@p.save
   end 
   page2 = Nokogiri::HTML(open("http://www.interfax.ru/news/"))
   page2.css(".an a").each do |link|
   loa
    @p=Page.new
    #@notice.notice=link.at_css(".ob_title").text
	#s=link.at_css(".photo_preview")
	#if !s.name="td"
	# @notice.ref_img=link.at_css(".photo_preview img")['src']
	#end 
	#@notice.ref_page=link.at_css(".ob_descr td a")['href']
	#@notice.name=link.at_css(".author").text
	
	#@notice.text=link.at_css("p[3]").text
	@p.title=link.text
	@p.ref="www.interfax.ru"+link['href']
	#@p.time=link.at_css(".b-item__time").text
	
	@p.save
  end 
 end 
  
  def index
  
    @pages = Page.all.order('created_at ASC')
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :ref, :time)
    end
end
