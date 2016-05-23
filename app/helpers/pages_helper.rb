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
	require 'will_paginate/array' 
def fetch_news
  @pages =  $redis.get("pages")
  
  if @pages.nil?
     @pages = Page.all.order('time DESC').page(params[:page]).to_json
    $redis.set("pages", @pages)
    # Expire the cache, reorder('time DESC').page(params[:page]).very 5 hours
    $redis.expire("pages",15.minute.to_i)
  end
  @pages = JSON.load @pages

  @sources =  $redis.get("sourses")
  if @sources.nil?
     @sources = Source.all.to_json
    $redis.set("sources", @sources)
     #Expire the cache, reorder('time DESC').page(params[:page]).very 5 hours
    $redis.expire("sources",5.hours.to_i)
  end
 
  @sources = JSON.load @sources
end
end
