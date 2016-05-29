class AddSourceToPages < ActiveRecord::Migration
  def change
    add_column :pages, :source, :string
    add_foreign_key :pages, column: :time
  end
end
