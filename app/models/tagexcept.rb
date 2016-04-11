# == Schema Information
#
# Table name: tagexcepts
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tagexcept < ActiveRecord::Base
end
