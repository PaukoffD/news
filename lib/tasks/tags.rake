  task :tags => :environment do
  	ActsAsTaggableOn.delimiter = ([' ', ','])
   @pages = Page.all
    @pages.each do |pt|
     if pt.tag_list.blank?
      pt.tag_list.add(pt.title, parse: true)
      pt.save
     end
   #  puts pt.tag_list
    end   
	tgs=Tagexcept.all
	tgs.each do |pt|
    result=ActsAsTaggableOn::Tag.where(name: pt.name)
    ActsAsTaggableOn::Tagging.where(tag_id: result).delete_all
	ActsAsTaggableOn::Tag.where(name: pt.name).delete_all
  end 