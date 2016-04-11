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

class Page < ActiveRecord::Base
belongs_to :source
belongs_to :levpage
validates :ref, uniqueness: true
acts_as_taggable_on :tags

self.per_page = 250


end
