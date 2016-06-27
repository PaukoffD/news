task html: :environment do
  source = Source.all
    source.html.each do |s|
       ss=Sourcehtml.first
       page = Nokogiri::HTML(open("#{ss.common1}"))
       link1=page.xpath("#{ss.common2}")
       link1.each do |link|
        pg=Page.new
        pg.title=eval("#{ss.title}")
        ref=eval("#{ss.ref}")
        pg.ref=ss.url+ref
        tt=eval("#{ss.time}")
        pg.time=tt.to_datetime
        pg.source_id=ss.source_id
        pg.save
      end 
    end
end