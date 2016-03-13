class Page < ActiveRecord::Base
belongs_to :source
has_many :levpages, :dependent => :destroy
validates :ref, uniqueness: true
acts_as_taggable

self.per_page = 250
end
