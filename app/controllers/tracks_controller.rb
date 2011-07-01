class TracksController < ApplicationController
  before_filter :authenticate
  def index
    render :layout => false
   @tracks= Track.paginate :page => params[:page], :order => 'created_at desc'
  end

  def clear
    Rails.cache.clear()
    render :text=>"cleared"
  end

end
