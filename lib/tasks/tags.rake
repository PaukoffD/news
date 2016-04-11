  task :tags => :environment do
   ActsAsTaggableOn.delimiter = ([' ', ','])
   str1=ActsAsTaggableOn::Tagging.last
   tmp1=str1.taggable_id.to_i
   @pages = Page.where("pages.id > ? ",tmp1 )
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