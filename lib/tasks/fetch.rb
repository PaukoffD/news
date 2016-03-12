 desc "task to get news from sources"
  task :fetch => :environment do
   


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
end

