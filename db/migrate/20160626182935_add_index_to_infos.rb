class AddIndexToInfos < ActiveRecord::Migration
  def change
  	add_index :infos, [:source_id, :data], unique: true
  end
end
