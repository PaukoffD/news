class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :ref

      t.timestamps null: false
    end
  end
end
