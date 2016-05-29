class AddIndexToPages < ActiveRecord::Migration
  def change
    add_index :pages, :ref, unique: true
  end
end
