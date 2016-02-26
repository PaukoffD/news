class CreateLevpages < ActiveRecord::Migration
  def change
    create_table :levpages do |t|
      t.integer :page_id
      t.integer :parent_id
      t.string :name
      t.integer :count, default: 0

      t.timestamps null: false
    end
  end
end
