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

class Levpage < ActiveRecord::Base
  has_many :page
  acts_as_tree
  extend ActsAsTree::TreeWalker

  acts_as_tree order: 'name'
end
