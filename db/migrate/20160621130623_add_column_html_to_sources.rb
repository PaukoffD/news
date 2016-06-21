class AddColumnHtmlToSources < ActiveRecord::Migration
  def change
    add_column :sources, :html, :boolean
  end
end
