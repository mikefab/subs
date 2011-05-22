class Cap < ActiveRecord::Base

def self.search(search,page,language)
  paginate :per_page=>5, :page=>page,
    :conditions => [language + ' like ? and eng != ? and spa != ? and spa!=eng', "%#{search}%", "",""],
    :order  => 'num'
  end

end
#:conditions => [language + ' like ? and eng != ? and spa != ?', "%#{search}%", "",""],
