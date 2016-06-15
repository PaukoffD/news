task infoday: :environment do
	  puts "beginning"
   @pages = Page.all.count
   @tags = ActsAsTaggableOn::Tag.all.count
   @taggings = ActsAsTaggableOn::Tagging.all.count
   @source = Source.all.count
   info=Info.first || Info.new
    puts info.page_count=@pages

    puts info.tag_count=@tags
    puts info.tagging=@taggings 
    puts info.size=@source
    info.save
end