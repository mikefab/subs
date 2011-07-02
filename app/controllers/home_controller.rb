class HomeController < ApplicationController
  def index
    grab_ip_info("index",0,0,"")
    @movies = Movie.find(:all)
    
  end

  def contact
  end
  
  def about
    
    grab_ip_info("about",0,0,"")
    
        @support = Support.new(:id => 1)


  end

end
