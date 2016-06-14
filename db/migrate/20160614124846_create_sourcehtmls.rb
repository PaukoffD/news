class CreateSourcehtmls < ActiveRecord::Migration
  def change
    create_table :sourcehtmls do |t|
      t.integer :source_id
      t.string  :url
      t.string  :common1 
      t.string  :common2 
      t.string  :common3 
      t.string  :common4 
      t.string  :common5
      t.string  :common6 
      t.string  :common7 
      t.string  :common8 
      t.string  :common9 
      t.string  :common10  
      t.string  :title
      t.string  :ref
      t.string  :time
      t.string  :image
      t.timestamps null: false
    end
  end
end
