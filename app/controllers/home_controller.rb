class HomeController < ApplicationController
  def index
    ip = request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
    Track.new(:ip=>ip,:search=>"index page").save!
    @movies = Movie.find(:all)
    
  end

  def contact
    ip = request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
    Track.new(:ip=>ip,:search=>"about page").save!
  end
  
  def about
        @support = Support.new(:id => 1)

  end

end
