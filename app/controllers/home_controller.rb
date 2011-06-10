class HomeController < ApplicationController
  def index
    Track.new(:ip=>request.env['REMOTE_ADDR'],:search=>"index page").save!
  end


  
  def about
  end

end
