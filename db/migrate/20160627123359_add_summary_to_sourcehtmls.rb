class AddSummaryToSourcehtmls < ActiveRecord::Migration
  def change
    add_column :sourcehtmls, :summary, :text
  end
end
