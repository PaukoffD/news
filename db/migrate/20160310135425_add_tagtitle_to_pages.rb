class AddTagtitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :tagtitle, :string
  end
end
