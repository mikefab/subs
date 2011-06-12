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

def self.trash()
  string  = "este"
  string = string.gsub(/e/,"\(e|é\)") if string
  return string
end

def self.search(search,page,language)
  if connection().to_s.match(/mysql/i) then
    Search.create(:search=>search, :lang=>language, :page=> page)
    paginate :per_page=>4, :page=>page,
#    :conditions => [language + ' REGEXP ? and eng != ? and spa != ? and hide is not TRUE and spa!=eng', "(^#{search}.?| #{search}[,\.\!\?\-]?$| #{search}[,\.\!\?]? )", "",""],
    :conditions => [language + ' REGEXP ? COLLATE UTF8_GENERAL_CI and eng != ? and spa != ? and hide is not TRUE and spa!=eng ', "[[:<:]]#{search}[[:>:]]", "",""],

    :order  => 'wcount'
  else
    Search.create(:search=>search, :lang=>language, :page=> page)
     paginate :per_page=>4, :page=>page,
      # :conditions => ['('+language + ' similar to ? or '+language+' similar to ?) and eng != ? and spa!=eng',"% #{search}(,|\.|\!|\?|\s+)%","%^#{search}(,|\.|\!|\?|\s+)%","1"],
       :conditions => [''+language + ' similar to ? and eng != ? and spa!=eng',"%\<#{search}\>%","1"],

      :order  => 'wcount'

    end
  end
end
#:conditions => [language + ' like ? and eng != ? and spa != ?', "%#{search}%", "",""],
