# == Schema Information
#
# Table name: levpages
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  parent_id  :integer
#  name       :string
#  count      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LevpageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
