class CreateAnalyzeTitles < ActiveRecord::Migration
  def change
    create_table :analyze_titles do |t|
      t.integer :page_id
      t.string :word1
      t.string :word2
	  t.string :word3
      t.string :word4
	  t.string :word5
      t.string :word6
	  t.string :word7
      t.string :word8
	  t.string :word9
      t.string :word10
	  t.timestamps null: false
    end
  end
end
