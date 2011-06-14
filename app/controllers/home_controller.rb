class HomeController < ApplicationController
  def index
    ip = request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
    Track.new(:ip=>ip,:search=>"index page").save!
  end


  
  def about
  end

end
