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
  require 'csv'

  include PagesHelper

  # GET /pages
  # GET /pages.json
  def load
    load_rss

   page = Nokogiri::HTML(open("http://utro.ru/news/"))
   page.xpath('/html/body/div[4]/div[4]/div/div[3]/div/div[3]').each do |link|
   puts link.at_css(" a").text
   # puts link
   # loa
  # Категории
          # page.css(".ms_child").each do |link|
          #puts link.text
          #st=link.text
          # c=Category.new
        #      st = link.at_css("tr[4] td[1] div a").text
           # puts link.at_css("tr[4] td[1] div a").text
         # c.name=st
         #//*[@id="new_content"]/div[3]/div/div/div/div/table/tbody/tr[3]/td[1]/div/a
        # puts c.name
        #c.save
        #puts //*[@id="new_content"]/div[3]/div/div/div/div/table/tbody/tr[1]/td[1]/div/a
        #end 
  #puts page.at_css(".ob_rubrika").text 
   
    #@topics = Topic.order(:created_at).reorder('id DESC').all.page(params[:page])
    #topic=Topic.order(:created_at).reorder('id DESC').last
  #@forum = Forum.find(topic.forum_id)
   #puts page.css("title")[0].name # => title
   #puts page.css("title")[0].text
  # page.css(".ob").each do |link|
  #  @notice=Tmpnotice.new
  #  @notice.notice=link.at_css(".ob_title").text
 # s=link.at_css(".photo_preview")
  #if !s.name="td"
 #  @notice.ref_img=link.at_css(".photo_preview img")['src']
 # end 
 # @notice.ref_page=link.at_css(".ob_descr td a")['href']
 # @notice.name=link.at_css(".author").text
  
  #@notice.text=link.at_css("p[3]").text
  
 # @notice.save
   end 
  end

      def analyze
    
      end

  def atags
   
  end

  def rtags # remove tags
    tgs = Tagexcept.all
   tgsovlp = Tagoverlap.all
   tgs.each do |pt|
      result = ActsAsTaggableOn::Tag.where(name: pt.name)
    ActsAsTaggableOn::Tagging.where(tag_id: result).delete_all
     ActsAsTaggableOn::Tag.where(name: pt.name).delete_all
   end
    tgsovlp.each do |pt1|
        result = ActsAsTaggableOn::Tag.where(name: pt1.name)
    result1 = ActsAsTaggableOn::Tag.where(name: pt1.nametarget)
    # res=result.tagging_count+result1.tagging_count
    
     if !result.blank? && !result1.blank?
      res = result[0]['taggings_count'] + result1[0]['taggings_count']
      result[0]['taggings_count'] = res
       ActsAsTaggableOn::Tagging.where(tag_id: result).update_all(tag_id: result[0]['id'])
     
      ActsAsTaggableOn::Tag.where(name: pt1.nametarget).update_all(taggings_count: res)
      ActsAsTaggableOn::Tag.where(name: pt1.name).delete_all
    
    else
    unless result.blank?
     ActsAsTaggableOn::Tagging.where(tag_id: result).update_all(tag_id: result[0]['id'])
     ActsAsTaggableOn::Tag.where(name: pt1.name).update_all(name: pt1.nametarget)
    end
    end
  end
    @cats=Category.all
    @cats.each do |cat|
      cat.count=Page.where(category_id: cat.id).count
      cat.save
   end
  
  end
  
  def search_tags1
    render :search_tags
     @tag = params[:tag]
     if @tag.blank?
      # loa
     # redirect_to :root, notice: "Заполни"
     else
       redirect_to :index, notice: "ищем!"
     end
  end

  def search_tags
  end

  def rss
    @source = Source.all
    lo
  end

  

  def info
    @pages = Page.all.count
   @tags = ActsAsTaggableOn::Tag.all.count
   @taggings = ActsAsTaggableOn::Tagging.all.count
   @source = Source.all.count
   @s = Source.all
    @s.each do |source|
    pages_count = source.pages.all.count
    info=Info.new #if Info.find(source_id: source.id).nil? 
    info.size=pages_count
    info.source_id=source.id
    info.save
    @pages = Page.uniq.pluck(:time)
    @pages.each do |p|
      puts p
    end  
   end 
    # loa
  end

  def index

  @translator = Yandex::Translator.new('trnsl.1.1.20160606T092333Z.48fc2e0ec17ebab3.69be4ac22af90838d34cb67de1e6dc0f2fe261c5')

    if params[:category]
      @pages = Page.where('category_id' => params['category']).order('time DESC').page(params[:page])
    elsif params[:tag]
      @pages = Page.tagged_with(params[:tag]).order('time DESC').page(params[:page])
    # loa
    elsif params[:data]
     @pages = Page.where(time: (params['data'].to_time.beginning_of_day..params['data'].to_time.end_of_day)).order('time DESC').page(params[:page])
    elsif params[:tags]
     @pages = Page.tagged_with(params[:tags]['tag']).order('time DESC').page(params[:page])
    elsif params[:q]
     @search = Page.search(params[:q])
    @pages = @search.result.order('time DESC').page(params[:page])
    elsif params[:format]
      @pages = Page.where('source_id' => params['format']).order('time DESC').page(params[:page])
    else
      @pages = Page.all.order('time DESC').page(params[:page])
    end
   
  
   # loa
   @categories = Category.all.order('count DESC').limit(50)
   @search = Page.search(params[:q])
    # @pages = @search.result.order('time DESC').page(params[:page])
  end

  def redis
   @source = Source.all
   fetch_news
  end

  def tag_cloud
       # @tags = Tags.all.order('count DESC')
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

  def tagexport
    @tags = ActsAsTaggableOn::Tag.all
    #loa
    f=File.new('tags.txt', 'w+') 

     @tags.each do |tt|
      f << tt.name + ";"
     # loa
     end
  end

  def tagimport
    #@tags = Tagecxept.new
   #csv_text = File.read('tags1.txt')
   csv = CSV.foreach('tags1.txt', :headers => false)
   csv.each do |row|
   a=row.to_s.split(";")
   a.each do |b|
    tag = Tagexcept.new
    if b.match("\\[")
       tag.name=b[2,b.length-2]
     elsif  !b.match('\\]')
       tag.name=b
     end
    tag.save
   end
   end
  end

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

  def set_page
    @page = Page.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit!
    params.require(:newslast).permit!
  end
end