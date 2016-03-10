class CreateTagoverlaps < ActiveRecord::Migration
  def change
    create_table :tagoverlaps do |t|
      t.integer :tag_id
      t.string :name
      t.integer :tagtarget_id
      t.string :nametarget

      t.timestamps null: false
    end
  end
end
