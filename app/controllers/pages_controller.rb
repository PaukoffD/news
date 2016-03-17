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
  plast=Newslast.find_by(source_id: s.id)
 
  feed.entries.each do |entry|
  if j<1
    
   
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
                if c.name==nil
                   c.name=="Без категории"
                end
		c.save
		cat1=Category.last
	  end	
       @p.category_id=cat1.id
       @p.summary=entry.summary
       @p.save
    else
      @p.ref=entry.url
        @p.time=entry.published
        @p.source_id=s.id
	s2=entry.categories[0]
	 
	 cat1=Category.find_by(name: s2)
	  if cat1.blank?
	    c=Category.new
		c.name=entry.categories[0]
                if c.name==nil
                   c.name=="Без категории"
                end
		c.save
		cat1=Category.last
	  end	
       @p.category_id=cat1.id
       @p.summary=entry.summary
       @p.save
    end
    
    
    end 
    
  end
#fixme не работает эта байда    
	Page.all.reorder('created_at DESC')
     @page1=Page.all.where(source_id: s)
	 @p1=Newslast.new
	
	 @p1.title=@page1.last.title
     @p1.time=@page1.last.created_at
     @p1.source_id=s.id
     @p1.ref=@page1.last.ref
     @p1.save
	 tmp=Newslast.all.where(source_id: s.id)
	 if tmp.count >1
	   p3=Newslast.first
	   p3.delete
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
   i=0  
   for j in 0..@pages.length-2
   lp=Levpage.new
   s1=@pages[j].title
   lp.page_id=@pages[j].id
   lp.name=@pages[j].title
   i=j+1
	 for i in i..@pages.length-1
	  s2=@pages[i].title
	  ld= Text::Levenshtein.distance(s1, s2)
	  puts ld, s1, s2, i, j
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
  
  def atags
   ActsAsTaggableOn.delimiter = ([' ', ','])
   @pages = Page.all
    @pages.each do |pt|
     if pt.tag_list.blank?
      pt.tag_list.add(pt.title, parse: true)
      pt.save
     end
     #puts pt.tag_list
    end   
  end 
  
  
  
  def index
  
   if params[:category]
     @pages = Page.where('category_id' => params['category']).order('time DESC').page(params[:page])
	elsif params[:tag]
     @pages = Page.tagged_with(params[:tag]).order('created_at DESC').page(params[:page])
    elsif params[:data]
	 @pages = Page.where(time: (params['data'].to_time.current.beginning_of_day..params['data'].to_time.end_of_day)).order('time DESC').page(params[:page])
    else
    @pages = Page.all.order('time DESC').page(params[:page])
    end
	
  
  
    
    @categories=Category.all

  end
  
def tag_cloud
 
   #@tags = Tags.all.order('count DESC')
  end
  
  
  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  
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
	  params.require(:newslast).permit!
    end
end
