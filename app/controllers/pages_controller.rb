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
  end

  

  def info
    @pages = Page.all.count
   @tags = ActsAsTaggableOn::Tag.all.count
   @taggings = ActsAsTaggableOn::Tagging.all.count
   @source = Source.all.count
   @s = Source.all
    # loa
  end

  def index



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