# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  title       :string
#  ref         :string
#  time        :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  source_id   :integer          default(0)
#  summary     :string
#  category_id :integer          default(0)
#  tagtitle    :string
#

class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  require 'open-uri'
  require 'rubygems'
  require 'text'
  require 'time'
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
       @p.time=entry.published.to_datetime.in_time_zone('Moscow')
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
       @p.time=entry.published.to_datetime
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
         if entry.summary.blank?
        
          entry.summary=" "
         else  
          @p.summary=entry.summary
         end 
        @p.save
        @p=Page.last
         ActsAsTaggableOn.delimiter = ([' ', ','])
         @p.tag_list.add(@p.title, parse: true)
         @p.save
      end
    end 
  end
end 
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
   str1=ActsAsTaggableOn::Tagging.last
   tmp1=str1.taggable_id.to_i
   @pages = Page.joins(:taggings)
   #@pages = Page.where("pages.id > ? ",tmp1 )
   #loa
   tgs=Tagexcept.all
    @pages.each do |pt|
    
     str=pt.tag_list.add(pt.title, parse: true)  
     
     pt.save
      
    end
    #puts pt.tag_list
   
	tgs.each do |tt|
    result=ActsAsTaggableOn::Tag.where(name: tt.name)
    ActsAsTaggableOn::Tagging.where(tag_id: result).delete_all
	ActsAsTaggableOn::Tag.where(name: tt.name).delete_all
    end   
  end 

  def rtags #remove tags
   
   tgs=Tagexcept.all
   tgsovlp=Tagoverlap.all
   tgs.each do |pt|
    result=ActsAsTaggableOn::Tag.where(name: pt.name)
    ActsAsTaggableOn::Tagging.where(tag_id: result).delete_all
	ActsAsTaggableOn::Tag.where(name: pt.name).delete_all
    end   
	tgsovlp.each do |pt1|
    result=ActsAsTaggableOn::Tag.where(name: pt1.name)
	result1=ActsAsTaggableOn::Tag.where(name: pt1.nametarget)
    ActsAsTaggableOn::Tagging.where(tag_id: result).update_all({:tag_id => result1})
	ActsAsTaggableOn::Tag.where(name: pt1.name).update_all({:name => pt1.nametarget})
    end   
	
  end 

def search_tags
   
  end 

 def search_tags1
    render :search_tags
    @tag = params[:tag]
    if @tag.blank?
     #loa
     # redirect_to :root, notice: "Заполни"
    else
      redirect_to :index, notice: "ищем!"
    end
  end 
  
  def info
   @pages=Page.all.count
   @tags = ActsAsTaggableOn::Tag.all.count
   @taggings = ActsAsTaggableOn::Tagging.all.count
   @source=Source.all.count
  end 
  
  def index
  
   if params[:category]
     @pages = Page.where('category_id' => params['category']).order('time DESC').page(params[:page])
 elsif params[:tag]
     @pages = Page.tagged_with(params[:tag]).order('created_at DESC').page(params[:page])
  else
   if params[:data]
    @pages = Page.where(time: (params['data'].to_time.beginning_of_day..params['data'].to_time.end_of_day)).order('time DESC').page(params[:page])
  elsif params[:tags]
    @pages = Page.tagged_with(params[:tags]['tag']).order('created_at DESC').page(params[:page])
    else
    @pages = Page.all.order('time DESC').page(params[:page])
    end
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
