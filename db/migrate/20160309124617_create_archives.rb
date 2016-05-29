class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :title
      t.string :ref
      t.time :time
      t.integer 'source_id', default: 0
      t.string   'summary'
      t.integer  'category_id', default: 0
      t.timestamps null: false
    end
  end
end
