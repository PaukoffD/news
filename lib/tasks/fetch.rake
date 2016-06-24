task fetch: :environment do
 source = Source.all
   source.each do |s|
    if !s.html
     url = s.ref
     feed = Feedjira::Feed.fetch_and_parse url
     feed.entries.each do |entry|
      @p = Page.new
      @p.title = entry.title
      @p.ref = entry.url
      @p.time = entry.published.to_datetime
      @p.source_id = s.id
      @p.image=entry.image if defined? entry.image
      s2 = entry.categories[0] if defined? entry.category
      cat1 = Category.find_by(name: s2)
      #cat1.name="Без категории" if cat1.name=="19"
      #cat1.save
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
        @p.summary = entry.summary[0..400]
       end
      @p.save
     
     end  
   end
else  
        ss=Sourcehtml.first
       page = Nokogiri::HTML(open("#{ss.common1}"))
       link1=page.xpath("#{ss.common2}")
       link1.each do |link|
        pg=Page.new
        pg.title=eval("#{ss.title}")
        ref=eval("#{ss.ref}")
        pg.ref=ss.url+ref
        tt=eval("#{ss.time}")
        pg.time=tt.to_datetime
        pg.source_id=ss.source_id
        pg.save
        
       end   
      
end