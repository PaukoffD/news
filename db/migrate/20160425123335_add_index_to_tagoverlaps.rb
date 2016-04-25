class AddIndexToTagoverlaps < ActiveRecord::Migration
  def change
    
    add_index :tagoverlaps, :name, unique: true
	add_index :tagoverlaps, :nametarget
  end
end
