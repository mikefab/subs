class Cap < ActiveRecord::Base

def self.search(search,page,language)
  paginate :per_page=>10, :page=>page,
    :conditions => [language + ' like ? and eng != ?', "%#{search}%", ""],
    :order  => 'num'
  end

end
