class CreateTagexcepts < ActiveRecord::Migration
  def change
    create_table :tagexcepts do |t|
      t.integer :tag_id
      t.string :name

      t.timestamps null: false
    end
  end
end
