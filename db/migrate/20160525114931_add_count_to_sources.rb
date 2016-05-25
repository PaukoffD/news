class AddCountToSources < ActiveRecord::Migration
  def change
    add_column :sources, :count, :integer
  end
end
