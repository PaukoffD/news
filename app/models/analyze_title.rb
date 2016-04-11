# == Schema Information
#
# Table name: analyze_titles
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  word1      :string
#  word2      :string
#  word3      :string
#  word4      :string
#  word5      :string
#  word6      :string
#  word7      :string
#  word8      :string
#  word9      :string
#  word10     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  word11     :string
#  word12     :string
#

class AnalyzeTitle < ActiveRecord::Base
end
