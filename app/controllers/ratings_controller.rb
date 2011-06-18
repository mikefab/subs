class RatingsController < ApplicationController

    def rating
      @cap = Cap.find_by_id(params[:cap_id])
      ip = request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
      print "#{ip} sssss\n"
    if  @cap.rate_it(params[:rating][@cap.id.to_s], ip) then
      @succeed=true
    else
      @succeed=false;
    end

    @h_ratings=Hash.new()
    h_rates  =Hash.new()

    Rate.find(:all).each do |r|
      h_rates[r.id]=r.score
    end

    Rating.find(:all,:conditions=>["user_id = ?",ip]).each do |r|
      @h_ratings[r.rateable_id]=h_rates[r.rate_id]
    end

    if @h_ratings[@cap.id] then
      @rate_default= @h_ratings[@cap.id]
    else
      @rate_default=5
    end
    
  end


end
