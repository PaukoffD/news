class ChangeColumnSourceFromPages < ActiveRecord::Migration
  def change
   change_column :pages, :source, :integer
  end
end
