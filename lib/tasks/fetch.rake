task fetch: :environment do
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
        @p.summary = entry.summary
       end
      @p.save
     
    end  
  end
end