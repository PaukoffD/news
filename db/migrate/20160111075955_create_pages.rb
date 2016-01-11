class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :ref
      t.time :time

      t.timestamps null: false
    end
  end
end
