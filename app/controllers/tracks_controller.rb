class TracksController < ApplicationController
  before_filter :authenticate
  def index
 
   @tracks= Track.paginate :page => params[:page], :order => 'created_at desc'
   
  end

  def clear
    Rails.cache.clear()
    render :text=>"cleared"
  end

end
