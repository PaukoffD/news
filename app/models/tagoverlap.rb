# == Schema Information
#
# Table name: tagoverlaps
#
#  id           :integer          not null, primary key
#  tag_id       :integer
#  name         :string
#  tagtarget_id :integer
#  nametarget   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tagoverlaps_on_name        (name) UNIQUE
#  index_tagoverlaps_on_nametarget  (nametarget)
#

class Tagoverlap < ActiveRecord::Base
end
