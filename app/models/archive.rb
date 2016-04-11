# == Schema Information
#
# Table name: archives
#
#  id          :integer          not null, primary key
#  title       :string
#  ref         :string
#  time        :time
#  source_id   :integer          default(0)
#  summary     :string
#  category_id :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Archive < ActiveRecord::Base
end
