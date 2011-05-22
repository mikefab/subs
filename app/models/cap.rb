# == Schema Information
# Schema version: 20110522210205
#
# Table name: caps
#
#  id         :integer(4)      not null, primary key
#  num        :integer(4)
#  spa        :string(255)
#  eng        :string(255)
#  por        :string(255)
#  rus        :string(255)
#  man        :string(255)
#  fre        :string(255)
#  start      :string(255)
#  stop       :string(255)
#  url        :string(255)
#  lang       :string(255)
#  source     :string(255)
#  source2    :string(255)
#  wcount     :integer(4)
#  ccount     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Cap < ActiveRecord::Base

def self.search(search,page,language)
  paginate :per_page=>5, :page=>page,
    :conditions => [language + ' like ? and eng != ? and spa != ? and spa!=eng', "%#{search}%", "",""],
    :order  => 'num'
  end

end
#:conditions => [language + ' like ? and eng != ? and spa != ?', "%#{search}%", "",""],
