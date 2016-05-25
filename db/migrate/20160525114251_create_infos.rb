class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.integer :source_id
      t.datetime :data
      t.integer :size

      t.timestamps null: false
    end
  end
end
