class AddCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :count, :integer
  end
end
