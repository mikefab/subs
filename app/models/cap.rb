class Cap < ActiveRecord::Base

def self.search(search,page)
  paginate :per_page=>5, :page=>page,
    :conditions => ['spa like ? and eng != ?', "%#{search}%", ""],
    :order  => 'num'
  end

end
