# require File.expand_path('../config/application.rb', __FILE__)
# desc "task to get news from sources"
task fetch: :environment do
  source = Source.all

  source.each do |s|
    url = s.ref
    i = 0
    j = 0
    feed = Feedjira::Feed.fetch_and_parse url
    plast = Newslast.find_by(source_id: s.id)

    feed.entries.each do |entry|
      next unless j < 1

      @p = Page.new
      @p.title = entry.title
      if !plast.blank?
        j = 1 if plast.title == @p.title
        @p.ref = entry.url
        @p.time = entry.published
        @p.source_id = s.id
        s2 = entry.categories[0]

        cat1 = Category.find_by(name: s2)
        if cat1.blank?
          c = Category.new
          c.name = entry.categories[0]
          c.name == "Без категории" if c.name.nil?
          c.save
          cat1 = Category.last
        end
        @p.category_id = cat1.id
        @p.summary = entry.summary
        @p.save
      else
        @p.ref = entry.url
        @p.time = entry.published
        @p.source_id = s.id
        s2 = entry.categories[0]

        cat1 = Category.find_by(name: s2)
        if cat1.blank?
          c = Category.new
          c.name = entry.categories[0]
          c.name == "Без категории" if c.name.nil?
          c.save
          cat1 = Category.last
           end
        @p.category_id = cat1.id
        @p.summary = entry.summary
        @p.save
     end
    end
  end
end
