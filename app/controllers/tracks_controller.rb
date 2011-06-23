class TracksController < ApplicationController
  def index
#         Rails.cache.clear()
   @tracks= Track.paginate :page => params[:page], :order => 'created_at desc'
   
  end

end
