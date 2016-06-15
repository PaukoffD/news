class AddPageCountToInfos < ActiveRecord::Migration
  def change
    add_column :infos, :page_count, :integer
    add_column :infos, :tag_count, :integer
    add_column :infos, :tagging, :integer
  end
end
