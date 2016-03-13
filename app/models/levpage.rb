class Levpage < ActiveRecord::Base
belongs_to :page, class_name: Page, foreign_key: "page_id"
end
