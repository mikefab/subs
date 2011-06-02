#encoding: utf-8
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
    search =search.gsub(/o/,"ó")
  Search.create(:search=>search, :lang=>language, :page=> page)

  paginate :per_page=>8, :page=>page,
  :conditions => ['('+language + ' like ? or ' + language + ' like ? or ' + language + ' like ?) and eng != ? and spa != ? and hide is not TRUE and spa!=eng', "% #{search} %","#{search} %","% #{search}", "",""],


  :order  => 'wcount'
  end

end
#:conditions => [language + ' like ? and eng != ? and spa != ?', "%#{search}%", "",""],
