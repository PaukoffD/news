class Levpage < ActiveRecord::Base
has_many :page
acts_as_tree
extend ActsAsTree::TreeWalker

  acts_as_tree order: 'name'
end
