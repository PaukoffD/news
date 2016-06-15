task infoday: :environment do
   @pages = Page.all.count
   @tags = ActsAsTaggableOn::Tag.all.count
   @taggings = ActsAsTaggableOn::Tagging.all.count
   @source = Source.all.count
   @s = Source.all
end