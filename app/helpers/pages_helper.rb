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

module PagesHelper
  require 'will_paginate/array'
  def fetch_news
    @pages = $redis.get('pages')

    if @pages.nil?
      @pages = Page.all.order('time DESC').page(params[:page]).to_json
      $redis.set('pages', @pages)
      # Expire the cache, reorder('time DESC').page(params[:page]).very 5 hours
      $redis.expire('pages', 15.minute.to_i)
    end
    @pages = JSON.load @pages

    @sources = $redis.get('sourses')
    if @sources.nil?
      @sources = Source.all.to_json
      $redis.set('sources', @sources)
      # Expire the cache, reorder('time DESC').page(params[:page]).very 5 hours
      $redis.expire('sources', 5.hours.to_i)
    end

    @sources = JSON.load @sources
  end

  def load_rss
     source = Source.all

   source.each do |s|
  url = s.ref
    i = 0
    j = 0
    feed = Feedjira::Feed.fetch_and_parse url
    plast = Newslast.find_by(source_id: s.id)

    feed.entries.each do |entry|
    next unless j<1


    @p = Page.new
    @p.title = entry.title
    if !plast.blank?
       j=1 if plast.title==@p.title
       @p.ref = entry.url
       @p.time = entry.published.to_datetime.in_time_zone('Moscow')
       @p.source_id = s.id
       s2 = entry.categories[0]

       cat1 = Category.find_by(name: s2)
     if cat1.blank?
      c = Category.new
      c.name = entry.categories[0]
               c.name=="Без категории" if c.name==nil
      c.save
      cat1 = Category.last
     end
       @p.category_id = cat1.id
       @p.summary = entry.summary
       @p.save
    else
      @p.ref = entry.url
      @p.time = entry.published.to_datetime
      @p.source_id = s.id
      s2 = entry.categories[0]

      cat1 = Category.find_by(name: s2)
      if cat1.blank?
         c = Category.new
         c.name = entry.categories[0]
               c.name=="Без категории" if c.name==nil
         c.save
         cat1 = Category.last
       end
      @p.category_id = cat1.id
      if entry.summary.blank?

        entry.summary = ' '
       else
        @p.summary = entry.summary
       end
      @p.save
      @p = Page.last
      ActsAsTaggableOn.delimiter = [' ', ',']
      @p.tag_list.add(@p.title, parse: true)
      @p.save
     
    end
   end
 end
  end  
end
