class TracksController < ApplicationController
  def index
   @tracks= Track.paginate :page => params[:page], :order => 'created_at desc'
   
  end

end
