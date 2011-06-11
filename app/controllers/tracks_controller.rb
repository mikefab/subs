class TracksController < ApplicationController
  def index
   @tracks= Track.paginate :page => params[:page], :order => 'id'
   
  end

end
