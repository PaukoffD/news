class AddIndexToTagexcepts < ActiveRecord::Migration
  def change
    add_index :tagexcepts, :name, unique: true
  end
end
