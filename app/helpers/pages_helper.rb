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

  def load_html
   page = Nokogiri::HTML(open("http://utro.ru/news/"))
   link1=page.xpath('/html/body/div[4]/div[4]/div/div[3]/div')
   link1.children.each do |link|
   #puts link.at_css(" a").text
   # puts link
   pg=Page.new
   pg.title=link.children.at_css("a").text
   pg.ref=link.children.at_css("a")['href']
   pg.time= link.children.at_css(" div div div").text
   pg.save
   
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
   page = Nokogiri::HTML(open("http://rueconomics.ru"))
   page.xpath('//*[contains(@class,"news")]').each do |link|
   #link1.children.each do |link|
   #puts link.at_css(" a").text
   next if link.values[0].match('city')
   next if link.values[0].match('choose')
   next if link.values[0].match('post')
   next if link.values[0].match('category')
   next if link.values[0].match('main')
   next if link.values[0].match('border')
    puts link
   #loa
   pg=Page.new
   pg.title=link.at_css("a").values[1]
   puts pg
   pg.ref=link.at_css("a").values[0]
   puts pg
   d=Date.today
   pg.time= link.at_css("div div").text.to_datetime
   puts pg
   pg.save
  end
end
    
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
    feed = Feedjira::Feed.fetch_and_parse url
    feed.entries.each do |entry|
      @p = Page.new
      @p.title = entry.title
      @p.ref = entry.url
      @p.time = entry.published.to_datetime
      @p.source_id = s.id
      @p.image=entry.image
      s2 = entry.categories[0]
      cat1 = Category.find_by(name: s2)
      cat1.name="Без категории" if cat1.id==19
      cat1.save
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