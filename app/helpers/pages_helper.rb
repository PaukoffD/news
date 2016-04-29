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
  @pages =  $redis.get("pages")
  if @pages.nil?
     @pages = Page.all.includes(:source).order('time DESC').to_json.page(params[:page])
    $redis.set("pages", @pages)
    # Expire the cache, reorder('time DESC').page(params[:page]).very 5 hours
    $redis.expire("pages",1.hour.to_i)
  end
  @pages = JSON.load @pages
end
end
