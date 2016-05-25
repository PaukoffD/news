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
#

class Info < ActiveRecord::Base
end
