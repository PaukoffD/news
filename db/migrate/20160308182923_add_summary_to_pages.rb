class AddSummaryToPages < ActiveRecord::Migration
  def change
    add_column :pages, :summary, :string
    add_column :pages, :category_id, :integer,    default:0
  end
end
