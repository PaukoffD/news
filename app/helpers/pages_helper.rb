# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  title       :string
#  ref         :string
#  time        :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  source_id   :integer          default(0)
#  summary     :string
#  category_id :integer          default(0)
#  tagtitle    :string
#

module PagesHelper
	def fetch_news
  @news =  $redis.get("news")
  if @news.nil?
     @news = Page.all.to_json
    $redis.set("news", @news)
    # Expire the cache, every 5 hours
    $redis.expire("news",5.hour.to_i)
  end
  @news = JSON.load @news
end
end
