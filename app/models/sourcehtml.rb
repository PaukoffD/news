# == Schema Information
#
# Table name: sourcehtmls
#
#  id         :integer          not null, primary key
#  source_id  :integer
#  url        :string
#  common1    :string
#  common2    :string
#  common3    :string
#  common4    :string
#  common5    :string
#  common6    :string
#  common7    :string
#  common8    :string
#  common9    :string
#  common10   :string
#  title      :string
#  ref        :string
#  time       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  summary    :text
#

class Sourcehtml < ActiveRecord::Base
	belongs_to :sources
end
