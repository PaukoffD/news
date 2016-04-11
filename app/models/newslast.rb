# == Schema Information
#
# Table name: newslasts
#
#  id         :integer          not null, primary key
#  source_id  :integer
#  page_id    :integer
#  title      :string
#  ref        :string
#  time       :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Newslast < ActiveRecord::Base
end
