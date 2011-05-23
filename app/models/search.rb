# == Schema Information
# Schema version: 20110523000737
#
# Table name: searches
#
#  id         :integer(4)      not null, primary key
#  search     :string(255)
#  user_id    :integer(4)
#  lang       :string(255)
#   page      :integer(4)
#  category   :string(255)
#  option     :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

class Search < ActiveRecord::Base
  belongs_to :user
  attr_accessible :search, :lang, :category, :option,:page

end
