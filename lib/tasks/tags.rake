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
  end 