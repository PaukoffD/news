# == Schema Information
#
# Table name: sources
#
#  id                  :integer          not null, primary key
#  name                :string
#  ref                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class Source < ActiveRecord::Base
has_many :pages
 has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>, :png", original: ['500x500>', :png] },
  convert_options: { thumb: "-quality 75 -strip", medium: "-quality 75 -strip", original: "-quality 85 -strip" },
 :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, size: { in: 0..500.kilobytes }, :content_type => /\Aimage\/.*\Z/
 
end
