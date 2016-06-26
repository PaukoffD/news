# == Schema Information
#
# Table name: infos
#
#  id         :integer          not null, primary key
#  source_id  :integer
#  data       :datetime
#  size       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_count :integer
#  tag_count  :integer
#  tagging    :integer
#
# Indexes
#
#  index_infos_on_source_id_and_data  (source_id,data) UNIQUE
#

class Info < ActiveRecord::Base
	belongs_to :source, inverse_of: :infos

    def todays
      @todays ||=Info.find_by(data: Date.current)
    end	
    
     def maptodays
      @todays ||=Info.find_by(data: Date.current)
    end	
end
