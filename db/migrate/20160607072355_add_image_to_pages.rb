class AddImageToPages < ActiveRecord::Migration
  def change
    add_column :pages, :image, :string
    change_column :pages, :time,  :datetime
  end
end
