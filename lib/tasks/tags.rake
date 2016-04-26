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
	tgsovlp.each do |pt1|
    result=ActsAsTaggableOn::Tag.where(name: pt1.name)
	result1=ActsAsTaggableOn::Tag.where(name: pt1.nametarget)
	#res=result.tagging_count+result1.tagging_count
	
	if !result.blank? && !result1.blank?
	 res=result[0]['taggings_count']+result1[0]['taggings_count'] 
	 result[0]['taggings_count']=res
     ActsAsTaggableOn::Tagging.where(tag_id: result).update_all({:tag_id => result1})
	 
	 ActsAsTaggableOn::Tag.where(name: pt1.nametarget).update_all({:taggings_count => res})
	 ActsAsTaggableOn::Tag.where(name: pt1.name).delete_all
	
	else
	 ActsAsTaggableOn::Tagging.where(tag_id: result).update_all({:tag_id => result1})
	 ActsAsTaggableOn::Tag.where(name: pt1.name).update_all({:name => pt1.nametarget})
	end
    end   
  end