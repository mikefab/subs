# app/controller/supports_controller.rb
class SupportsController < ApplicationController
  def new
    # id is required to deal with form
    @support = Support.new(:id => 1)
  end

  def create
    @support = Support.new(params[:support])
    if @support.save
    
      redirect_to('/', :notice => "Your message was sent. Thank you.")
    else

      flash[:alert] = "You must fill all fields."
      render 'new'
    end
  end
end
