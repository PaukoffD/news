class CreateNewslasts < ActiveRecord::Migration
  def change
    create_table :newslasts do |t|
      t.integer :source_id
      t.integer :page_id
      t.string :title
      t.string :ref
      t.time :time

      t.timestamps null: false
    end
  end
end
