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
#  image       :string
#
# Indexes
#
#  index_pages_on_ref  (ref) UNIQUE
#

class Page < ActiveRecord::Base
  belongs_to :source
  belongs_to :levpage
  validates :ref, uniqueness: true # validates_uniqueness_of :title, conditions: -> { where.not(status: 'archived') }
  acts_as_taggable_on :tags

  self.per_page = 500
end
