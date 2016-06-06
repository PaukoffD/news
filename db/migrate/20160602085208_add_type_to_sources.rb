class AddTypeToSources < ActiveRecord::Migration
  def change
    add_column :sources, :type, :text
  end
end
