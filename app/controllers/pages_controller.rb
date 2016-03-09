class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  require 'open-uri'
  require 'rubygems'
  require 'text'
  # GET /pages
  # GET /pages.json
  def load
  source=Source.all

  source.each do |s|
   url=s.ref
   i=0
   j=0
   feed = Feedjira::Feed.fetch_and_parse url
  
 
  feed.entries.each do |entry|
  if j<1
    @p=Page.new
    plast=Newslast.find_by(source_id: s.id)
   @p=Page.new
   @p.title=entry.title
    if !plast.blank?
        if plast.title==@p.title
	  j=1
	end  
     @p.ref=entry.url
     @p.time=entry.published
     @p.source_id=s.id
	 s2=entry.categories[0]
	 
	 cat1=Category.find_by(name: s2)
	  if cat1.blank?
	    c=Category.new
		c.name=entry.categories[0]
		c.save
		cat1=Category.last
	  end	
     @p.category_id=cat1.id
     @p.summary=entry.summary
     @p.save
    else
     if i==feed.entries.length-1
	 @p1=Newslast.new
	  @p1.title=entry.title
	  @p1.time=entry.published
          @p1.source_id=s.id
	 # @p1.save
     else
         @p1=Newslast.new
	  @p1.title=entry.title
	  @p1.time=entry.published
          @p1.source_id=s.id
	  @p1.save
     end 
	 i=i+1
    end 
  end
 end
end
  
 
  
 # page3 = Nokogiri::HTML(open("http://www.vedomosti.ru/newsline/top"))
 #  page3.xpath("//article[@class='b-news-item']").each do |link|
   
  #  @p=Page.new
#	@p.title=link.at_css('a').text
#	@p.ref="http://www.vedomosti.ru"+link.at_css('a')['href']
#	@p.time=link.at_css('.b-news-item__time')['pubdate'].to_datetime
	
#	@p.save

  
  
 
 end 
  
  
  def analyze
   @pages=Page.all  
   for j in 0..@pages.length-2
   lp=Levpage.new
   s1=@pages[j].title
   lp.page_id=@pages[j].id
   lp.name=@pages[j].title
   
	 for i in 1..@pages.length-1
	  s2=@pages[i].title
	  ld= Text::Levenshtein.distance(s1, s2)
	  puts ld, s1, s2 
      if ld<15 and @pages[i].id!=@pages[j].id
       #lp1=Levpage.last 	  
	   lp2=Levpage.new
	   lp2.parent_id=lp.page_id
	   lp2.name=@pages[i].title
	   lp2.page_id=@pages[i].id
	   lp.save
	   lp2.save
	  end 
	 end
	end 
  end
  
  
  
  
  
  def index
  
    @pages = Page.all.order('time DESC')
    @categories=Category.all
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
      params.require(:page).permit!
    end
end
