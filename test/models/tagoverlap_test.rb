# == Schema Information
#
# Table name: tagoverlaps
#
#  id           :integer          not null, primary key
#  tag_id       :integer
#  name         :string
#  tagtarget_id :integer
#  nametarget   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class TagoverlapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
