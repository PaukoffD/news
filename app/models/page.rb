class Page < ActiveRecord::Base
belongs_to :source
belongs_to :levpage
validates :ref, uniqueness: true
acts_as_taggable_on :tags

self.per_page = 250


end