class AddColumnToAnalyzeTitles < ActiveRecord::Migration
  def change
    add_column :analyze_titles, :word11, :string
    add_column :analyze_titles, :word12, :string
  end
end
