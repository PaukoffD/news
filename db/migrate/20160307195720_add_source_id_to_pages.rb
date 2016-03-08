class AddSourceIdToPages < ActiveRecord::Migration
  def change
    change_column :pages, :source_id, :integer
  end
end
