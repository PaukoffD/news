task tags: :environment do
 # ActsAsTaggableOn.delimiter = [' ', ',']
 puts "Work with tags" 
  
  @pages = Page.joins('LEFT OUTER JOIN "taggings" ON "taggings"."taggable_id" = "pages"."id"').where(taggings: {taggable_id: nil}).limit(1000)
   ActsAsTaggableOn.delimiter = [' ']
   @pages.each do |p|   
     p.tag_list.add(p.title, parse: true)
     p.save
    end 
  tgs = Tagexcept.all
  tgsovlp = Tagoverlap.all
   
  tgs.each do |tt|
    result = ActsAsTaggableOn::Tag.where(name: tt.name)
    ActsAsTaggableOn::Tagging.where(tag_id: result).delete_all
    ActsAsTaggableOn::Tag.where(name: tt.name).delete_all
  end
  tgsovlp.each do |pt1|
    result = ActsAsTaggableOn::Tag.where(name: pt1.name)
    result1 = ActsAsTaggableOn::Tag.where(name: pt1.nametarget)
    # res=result.tagging_count+result1.tagging_count

    if !result.blank? && !result1.blank?
      res = result[0]['taggings_count'] + result1[0]['taggings_count']
      result[0]['taggings_count'] = res
      ActsAsTaggableOn::Tagging.where(tag_id: result).update_all(tag_id: result1)

      ActsAsTaggableOn::Tag.where(name: pt1.nametarget).update_all(taggings_count: res)
      ActsAsTaggableOn::Tag.where(name: pt1.name).delete_all

    else
      unless result.blank?
        ActsAsTaggableOn::Tagging.where(tag_id: result).update_all(tag_id: result[0]['id'])
        ActsAsTaggableOn::Tag.where(name: pt1.name).update_all(name: pt1.nametarget)
      end
    end
  end
end
